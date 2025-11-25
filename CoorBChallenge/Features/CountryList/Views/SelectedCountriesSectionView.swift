//
//  SelectedCountriesSectionView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct SelectedCountriesSectionView: View {
    let countries: [Country]
    let onTap: (Country) -> Void
    let onRemove: (Country) -> Void

    var body: some View {
        ForEach(countries) { country in
            CountryRowView(
                country: country,
                accessory: .chevron
            )
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            .listRowBackground(Color.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                onTap(country)
            }
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    onRemove(country)
                } label: {
                    Label("Remove", systemImage: "trash")
                }
            }
        }
    }
}
