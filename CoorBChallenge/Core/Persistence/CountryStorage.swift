//
//  CountryStorage.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

enum CountryStorageError: Error {
    case encodingFailed(Error)
    case decodingFailed(Error)
}

final class CountryStorage: CountryStorageProtocol {

    private let userDefaults: UserDefaults
    private let key: String

    init(
        userDefaults: UserDefaults = .standard,
        key: String = StorageKeys.selectedCountries
    ) {
        self.userDefaults = userDefaults
        self.key = key
    }

    func loadSelectedCountries() throws -> [Country] {
        // First launch: nothing saved yet
        guard let data = userDefaults.data(forKey: key) else {
            return []
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Country].self, from: data)
        } catch {
            throw CountryStorageError.decodingFailed(error)
        }
    }

    func saveSelectedCountries(_ countries: [Country]) throws {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(countries)
            userDefaults.set(data, forKey: key)
        } catch {
            throw CountryStorageError.encodingFailed(error)
        }
    }
}
