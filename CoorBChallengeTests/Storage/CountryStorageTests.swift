//
//  CountryStorageTests.swift
//  CoorBChallengeTests
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import XCTest
@testable import CoorBChallenge

final class CountryStorageTests: XCTestCase {

    var storage: CountryStorage!
    let mockDefaults = UserDefaults(suiteName: "CountryStorageTests")!

    override func setUp() {
        super.setUp()
        mockDefaults.removePersistentDomain(forName: "CountryStorageTests")
        storage = CountryStorage(userDefaults: mockDefaults)
    }

    override func tearDown() {
        mockDefaults.removePersistentDomain(forName: "CountryStorageTests")
        storage = nil
        super.tearDown()
    }

    func test_saveAndLoadCountries_returnsSameData() throws {
        // GIVEN
        let countries = [
            Country(
                name: "Egypt",
                alpha2Code: "EG",
                capital: "Cairo",
                region: "Africa",
                flag: nil,
                currencies: nil
            )
        ]

        // WHEN
        try storage.saveSelectedCountries(countries)
        let loaded = try storage.loadSelectedCountries()

        // THEN
        XCTAssertEqual(loaded, countries)
    }

    func test_loadWithoutSaving_returnsEmptyArray() throws {
        // WHEN
        let loaded = try storage.loadSelectedCountries()

        // THEN
        XCTAssertTrue(loaded.isEmpty)
    }
}
