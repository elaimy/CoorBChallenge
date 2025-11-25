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
    let onToggleSelection: (Country) -> Void

    var body: some View {
        ForEach(countries) { country in
            let isSelected = selectedCountries.contains { $0.alpha2Code == country.alpha2Code }
            let canSelectMore = selectedCountries.count < maxSelected

            CountryRowView(
                country: country,
                accessory: accessory(for: isSelected, canSelectMore: canSelectMore)
            )
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            .listRowBackground(Color.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                // If already selected -> do nothing
                guard !isSelected else { return }

                // Not selected -> always notify view model
                // ViewModel will either add or show "max reached" alert
                onToggleSelection(country)
            }
        }
    }

    private func accessory(for isSelected: Bool, canSelectMore: Bool) -> CountryRowAccessory {
        if isSelected {
            return .checkmark          // already selected
        } else if canSelectMore {
            return .plus               // can still add more
        } else {
            return .plus               // or .none if you want it to “disappear”
        }
    }
}
