//
//  CountryStorageProtocol.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

protocol CountryStorageProtocol {
    func loadSelectedCountries() throws -> [Country]
    func saveSelectedCountries(_ countries: [Country]) throws
}
