//
//  LocationServiceProtocol.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

protocol LocationServiceProtocol {
    func requestAuthorization()
    func currentCountryCode() async throws -> String?
}
