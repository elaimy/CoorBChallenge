//
//  CountryFlagView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct CountryFlagView: View {
    let flagCountryCode: String

    var body: some View {
        Text(flagEmoji(for: flagCountryCode))
            .font(.system(size: 30))
            .frame(width: 40, height: 28)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private func flagEmoji(for code: String) -> String {
        let base: UInt32 = 127397
        var scalars = String.UnicodeScalarView()
        for scalar in code.uppercased().unicodeScalars {
            if let flagScalar = UnicodeScalar(base + scalar.value) {
                scalars.append(flagScalar)
            }
        }
        return String(scalars)
    }
}
