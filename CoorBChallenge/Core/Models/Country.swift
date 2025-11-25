//
//  Country.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

struct Country: Identifiable, Codable, Equatable {
    // Using alpha2Code as unique ID.
    var id: String { alpha2Code }

    let name: String
    let alpha2Code: String
    let capital: String?
    let region: String?
    let flag: String?
    let currencies: [Currency]?

    struct Currency: Codable, Equatable {
        let code: String?
        let name: String?
        let symbol: String?
    }
}

extension Country {
    var flagEmoji: String {
        let base: UInt32 = 127397 // regional indicator symbol base
        var scalars = String.UnicodeScalarView()
        for scalar in alpha2Code.uppercased().unicodeScalars {
            if let flagScalar = UnicodeScalar(base + scalar.value) {
                scalars.append(flagScalar)
            }
        }
        return String(scalars)
    }
}
