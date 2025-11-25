//
//  LocationError.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

enum LocationError: Error {
    case locationServicesDisabled
    case authorizationDenied
    case geocodingFailed(Error)
    case unknown
}
