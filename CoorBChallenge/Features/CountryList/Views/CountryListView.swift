//
//  CountryListView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct CountryListView: View {
    @StateObject var viewModel: CountryListViewModel

    var body: some View {
        NavigationStack {
            List {
                // Selected countries section
                if !viewModel.selectedCountries.isEmpty {
                    Section {
                        SelectedCountriesSectionView(
                            countries: viewModel.selectedCountries,
                            onTap: { country in
                                viewModel.didTapCountry(country)
                            },
                            onRemove: { country in
                                viewModel.removeCountry(country)
                            }
                        )
                    } header: {
                        Text("Selected Countries (Max 5)")
                            .font(.headline)
                    }
                }

                // All countries section
                Section {
                    CountrySearchBar(text: $viewModel.searchQuery)

                    AllCountriesSectionView(
                        countries: viewModel.filteredAllCountries,
                        selectedCountries: viewModel.selectedCountries,
                        maxSelected: 5,
                        onTap: { country in
                            viewModel.didTapCountry(country)
                        },
                        onToggleSelection: { country in
                            viewModel.toggleSelection(for: country)
                        }
                    )
                } header: {
                    Text("All Countries")
                        .font(.headline)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Countries")
            .refreshable {
                await viewModel.refresh()
            }
            .overlay {
                if viewModel.isLoading && viewModel.allCountries.isEmpty {
                    ProgressView()
                }
            }
            .alert("Error", isPresented: $viewModel.hasError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Something went wrong")
            }
        }
    }
}
