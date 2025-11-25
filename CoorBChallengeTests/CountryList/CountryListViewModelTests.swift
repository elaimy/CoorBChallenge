//
//  CountryListViewModelTests.swift
//  CoorBChallengeTests
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import XCTest
@testable import CoorBChallenge

// MARK: - Simple Mocks

final class MockCountryService: CountryServiceProtocol {
    var countriesToReturn: [Country] = []

    func fetchAllCountries() async throws -> [Country] {
        countriesToReturn
    }
}


final class MockCountryStorage: CountryStorageProtocol {
    var storedCountries: [Country] = []

    func loadSelectedCountries() throws -> [Country] {
        storedCountries
    }

    func saveSelectedCountries(_ countries: [Country]) throws {
        storedCountries = countries
    }
}

// MARK: - Tests

@MainActor
final class CountryListViewModelTests: XCTestCase {

    private var countryService: MockCountryService!
    private var locationService: MockLocationService!
    private var storage: MockCountryStorage!
    private var viewModel: CountryListViewModel!

    // Some sample countries we can reuse
    private let sampleCountries: [Country] = [
        Country(
            name: "Egypt",
            alpha2Code: "EG",
            capital: "Cairo",
            region: "Africa",
            flag: nil,
            currencies: nil
        ),
        Country(
            name: "Germany",
            alpha2Code: "DE",
            capital: "Berlin",
            region: "Europe",
            flag: nil,
            currencies: nil
        ),
        Country(
            name: "France",
            alpha2Code: "FR",
            capital: "Paris",
            region: "Europe",
            flag: nil,
            currencies: nil
        )
    ]

    override func setUp() {
        super.setUp()
        countryService = MockCountryService()
        locationService = MockLocationService()
        storage = MockCountryStorage()

        viewModel = CountryListViewModel(
            countryService: countryService,
            locationService: locationService,
            storage: storage,
            defaultCountryCode: "EG"
        )
    }

    override func tearDown() {
        viewModel = nil
        countryService = nil
        locationService = nil
        storage = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_filteredAllCountries_whenSearchEmpty_returnsAll() {
        viewModel.allCountries = sampleCountries
        viewModel.searchQuery = ""

        let result = viewModel.filteredAllCountries

        XCTAssertEqual(result.count, sampleCountries.count)
    }

    func test_filteredAllCountries_filtersByNameOrCapital() {
        viewModel.allCountries = sampleCountries
        viewModel.searchQuery = "berlin"   // capital of Germany

        let result = viewModel.filteredAllCountries

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Germany")
    }

    func test_addCountry_doesNotExceedMaxFive() {
        // Create 6 different countries
        let manyCountries = (1...6).map { index in
            Country(
                name: "Country \(index)",
                alpha2Code: "C\(index)",
                capital: "Capital \(index)",
                region: nil,
                flag: nil,
                currencies: nil
            )
        }

        manyCountries.forEach { country in
            viewModel.addCountry(country)
        }

        XCTAssertEqual(viewModel.selectedCountries.count, 5, "Should not select more than 5 countries")
    }

    func test_toggleSelection_removesWhenAlreadySelected() {
        let egypt = sampleCountries[0]

        // First add it
        viewModel.addCountry(egypt)
        XCTAssertEqual(viewModel.selectedCountries.count, 1)

        // Then toggle -> should remove
        viewModel.toggleSelection(for: egypt)

        XCTAssertTrue(viewModel.selectedCountries.isEmpty)
    }
}
