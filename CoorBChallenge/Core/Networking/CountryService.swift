//
//  CountryService.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

final class CountryService: CountryServiceProtocol {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchAllCountries() async throws -> [Country] {

        let endpoint = "all?fields=name,alpha2Code,capital,region,flag,currencies"
        let fullURLString = APIConstants.baseURL + endpoint

        guard let url = URL(string: fullURLString) else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, response) = try await session.data(from: url)

            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }

            guard (200...299).contains(http.statusCode) else {
                throw NetworkError.badStatusCode(http.statusCode)
            }

            guard !data.isEmpty else {
                throw NetworkError.noData
            }

            do {
                let decoder = JSONDecoder()
                return try decoder.decode([Country].self, from: data)
            } catch {
                throw NetworkError.decodingFailed(error)
            }

        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.requestFailed(error)
        }
    }
}
