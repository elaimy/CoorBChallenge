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
            ZStack(alignment: .bottom) {
                List {
                    // Selected countries
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

                    // All countries
                    Section {
                        AllCountriesSectionView(
                            countries: viewModel.filteredAllCountries,
                            selectedCountries: viewModel.selectedCountries,
                            maxSelected: 5,
                            onToggleSelection: { country in
                                viewModel.toggleSelection(for: country)
                            }
                        )
                    } header: {
                        Text("All Countries")
                            .font(.headline)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.bottom, 72) // leave space for the search bar
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

                // Bottom floating search bar
                CountrySearchBar(text: $viewModel.searchQuery)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
        }
        .task {
            viewModel.onAppear()
        }
    }
}
