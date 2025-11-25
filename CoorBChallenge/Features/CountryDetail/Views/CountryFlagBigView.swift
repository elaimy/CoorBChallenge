//
//  CountryFlagBigView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct CountryFlagBigView: View {
    let alpha2Code: String

    var body: some View {
        Text(flagEmoji(for: alpha2Code))
            .font(.system(size: 120))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 6)
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
