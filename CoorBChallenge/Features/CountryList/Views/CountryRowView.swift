//
//  CountryRowView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

enum CountryRowAccessory {
    case chevron
    case plus
    case checkmark
    case none
}

struct CountryRowView: View {
    let country: Country
    let accessory: CountryRowAccessory

    var body: some View {
        HStack(spacing: 12) {
            CountryFlagView(flagURLString: country.flag)

            VStack(alignment: .leading, spacing: 4) {
                Text(country.name)
                    .font(.body)
                if let capital = country.capital, !capital.isEmpty {
                    Text(capital)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            switch accessory {
            case .chevron:
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            case .plus:
                Image(systemName: "plus.circle")
                    .foregroundColor(.blue)
            case .checkmark:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            case .none:
                EmptyView()
            }
        }
        .padding(.vertical, 4)
    }
}
