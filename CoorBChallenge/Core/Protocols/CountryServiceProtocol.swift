//
//  CountryServiceProtocol.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

protocol CountryServiceProtocol {
    func fetchAllCountries() async throws -> [Country]
}
