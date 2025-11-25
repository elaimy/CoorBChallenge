//
//  AllCountriesSectionView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct AllCountriesSectionView: View {
    let countries: [Country]
    let selectedCountries: [Country]
    let maxSelected: Int
    let onTap: (Country) -> Void
    let onToggleSelection: (Country) -> Void

    var body: some View {
        ForEach(countries) { country in
            let isSelected = selectedCountries.contains(where: { $0.alpha2Code == country.alpha2Code })
            let canSelectMore = selectedCountries.count < maxSelected || isSelected

            CountryRowView(
                country: country,
                accessory: accessory(for: isSelected, canSelectMore: canSelectMore)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                onTap(country)
            }
            .onTapGesture {
                if canSelectMore {
                    onToggleSelection(country)
                }
            }
        }
    }

    private func accessory(for isSelected: Bool, canSelectMore: Bool) -> CountryRowAccessory {
        if isSelected {
            return .checkmark
        } else if canSelectMore {
            return .plus
        } else {
            return .none
        }
    }
}
