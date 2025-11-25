//
//  SelectedCountriesSectionView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct SelectedCountriesSectionView: View {
    let countries: [Country]
    let onRemove: (Country) -> Void

    var body: some View {
        ForEach(countries) { country in
            NavigationLink {
                CountryDetailView(country: country)
            } label: {
                CountryRowView(
                    country: country,
                    accessory: .none        
                )
            }
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            .listRowBackground(Color.clear)
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
