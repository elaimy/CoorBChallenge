//
//  LocationService.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {

    private let locationManager: CLLocationManager
    private var continuation: CheckedContinuation<String?, Error>?

    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    // Ask the system for permission
    func requestAuthorization() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    // Returns the user’s country code (ex: "DE"), or nil if permission is denied
    func currentCountryCode() async throws -> String? {
        // Location services completely off
        guard CLLocationManager.locationServicesEnabled() else {
            return nil
        }

        let status = locationManager.authorizationStatus

        switch status {
        case .denied, .restricted:
            // User said no → just return nil so caller can pick a fallback
            return nil

        case .notDetermined:
            // If needed, request permission again
            locationManager.requestWhenInUseAuthorization()

        default:
            break
        }

        // If we already have a location from the system, use it
        if let location = locationManager.location {
            return try await reverseGeocode(location: location)
        }

        // Otherwise wait for one update
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            locationManager.requestLocation()
        }
    }

    // Convert coordinates to a country code
    private func reverseGeocode(location: CLLocation) async throws -> String? {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        return placemarks.first?.isoCountryCode
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let continuation = continuation else { return }
        guard let location = locations.first else {
            continuation.resume(returning: nil)
            self.continuation = nil
            return
        }

        Task {
            do {
                let code = try await reverseGeocode(location: location)
                continuation.resume(returning: code)
            } catch {
                continuation.resume(throwing: error)
            }
            self.continuation = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
    
}
