//
//  MockLocationService.swift
//  CoorBChallengeTests
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation
@testable import CoorBChallenge

final class MockLocationService: LocationServiceProtocol {

    var requestedAuthorization = false
    var countryCodeToReturn: String?
    var errorToThrow: Error?

    func requestAuthorization() {
        requestedAuthorization = true
    }

    func currentCountryCode() async throws -> String? {
        if let error = errorToThrow {
            throw error
        }
        return countryCodeToReturn
    }
}
