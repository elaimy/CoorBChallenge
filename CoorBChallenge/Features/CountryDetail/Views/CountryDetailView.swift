//
//  CountryDetailView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // Big flag card
                CountryFlagBigView(alpha2Code: country.alpha2Code)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)

                // Country name
                Text(country.name)
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)

                // Info card
                VStack(alignment: .leading, spacing: 12) {
                    InfoRow(title: "Capital", value: country.capital ?? "—")
                    InfoRow(title: "Region", value: country.region ?? "—")
                    InfoRow(title: "Currency", value: currencyText)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.horizontal, 16)

                Spacer(minLength: 24)
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Simple formatting for currencies
    private var currencyText: String {
        guard let currency = country.currencies?.first else {
            return "—"
        }

        let code = currency.code ?? ""
        let name = currency.name ?? ""
        let symbol = currency.symbol ?? ""

        switch (name.isEmpty, code.isEmpty, symbol.isEmpty) {
        case (false, false, false):
            return "\(name) (\(code), \(symbol))"
        case (false, false, true):
            return "\(name) (\(code))"
        case (false, true, false):
            return "\(name) (\(symbol))"
        default:
            return name.isEmpty ? "—" : name
        }
    }
}
