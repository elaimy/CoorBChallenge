//
//  CountryListViewModel.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation
import Combine

@MainActor
final class CountryListViewModel: ObservableObject {

    // MARK: - Dependencies

    private let countryService: CountryServiceProtocol
    private let locationService: LocationServiceProtocol
    private let storage: CountryStorageProtocol
    private let defaultCountryCode: String

    // MARK: - State

    @Published var allCountries: [Country] = []
    @Published var selectedCountries: [Country] = []
    @Published var searchQuery: String = ""

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var hasError: Bool = false

    private var didLoadOnce = false
    private let maxSelected = 5

    // MARK: - Init

    init(
        countryService: CountryServiceProtocol,
        locationService: LocationServiceProtocol,
        storage: CountryStorageProtocol,
        defaultCountryCode: String = "EG"
    ) {
        self.countryService = countryService
        self.locationService = locationService
        self.storage = storage
        self.defaultCountryCode = defaultCountryCode
    }

    // MARK: - Derived data

    var filteredAllCountries: [Country] {
        guard !searchQuery.isEmpty else { return allCountries }

        let query = searchQuery.lowercased()

        return allCountries.filter {
            $0.name.lowercased().contains(query) ||
            ($0.capital ?? "").lowercased().contains(query)
        }
    }

    // MARK: - Lifecycle

    func onAppear() {
        guard !didLoadOnce else { return }
        didLoadOnce = true

        Task {
            await loadInitialData()
        }
    }

    func refresh() async {
        await fetchCountries(showLoader: false)
    }

    // MARK: - Public actions

    func toggleSelection(for country: Country) {
        if selectedCountries.contains(where: { $0.alpha2Code == country.alpha2Code }) {
            removeCountry(country)
        } else {
            addCountry(country)
        }
    }

    func addCountry(_ country: Country) {
        guard !selectedCountries.contains(where: { $0.alpha2Code == country.alpha2Code }) else { return }
        guard selectedCountries.count < maxSelected else { return }

        selectedCountries.append(country)
        saveSelection()
    }

    func removeCountry(_ country: Country) {
        selectedCountries.removeAll { $0.alpha2Code == country.alpha2Code }
        saveSelection()
    }

    func didTapCountry(_ country: Country) {
        // Here you navigate to the detail screen
    }

    // MARK: - Private

    private func loadInitialData() async {
        loadFromStorage()
        await fetchCountries(showLoader: true)
        await ensureInitialSelectedCountry()
    }

    private func loadFromStorage() {
        do {
            let stored = try storage.loadSelectedCountries()
            selectedCountries = Array(stored.prefix(maxSelected))
        } catch {
            
        }
    }

    private func saveSelection() {
        do {
            try storage.saveSelectedCountries(selectedCountries)
        } catch {
            
        }
    }

    private func fetchCountries(showLoader: Bool) async {
        if showLoader {
            isLoading = true
        }

        defer {
            isLoading = false
        }

        do {
            let countries = try await countryService.fetchAllCountries()
            allCountries = countries.sorted { $0.name < $1.name }
            clearError()
        } catch {
            showError(error)
        }
    }

    private func ensureInitialSelectedCountry() async {
        guard selectedCountries.isEmpty else { return }
        guard !allCountries.isEmpty else { return }

        do {
            let code = try await locationService.currentCountryCode()

            if let countryCode = code,
               let match = allCountries.first(where: { $0.alpha2Code == countryCode }) {
                addCountry(match)
                return
            }

            // No location / not found -> fallback to your country
            if let fallback = allCountries.first(where: { $0.alpha2Code == defaultCountryCode }) {
                addCountry(fallback)
            }

        } catch {
            // On any error, just use the default country if we can find it
            if let fallback = allCountries.first(where: { $0.alpha2Code == defaultCountryCode }) {
                addCountry(fallback)
            }
        }
    }

    // MARK: - Error handling

    private func showError(_ error: Error) {
        hasError = true

        if let networkError = error as? NetworkError,
           let message = networkError.errorDescription {
            errorMessage = message
        } else {
            errorMessage = "Something went wrong. Please try again."
        }
    }

    private func clearError() {
        hasError = false
        errorMessage = nil
    }
}
