//
//  CountryServiceTests.swift
//  CoorBChallengeTests
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import XCTest
@testable import CoorBChallenge

final class CountryServiceTests: XCTestCase {

    private var session: URLSession!
    private var service: CountryService!

    override func setUp() {
        super.setUp()

        // Create a URLSession that uses our MockURLProtocol
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: configuration)

        service = CountryService(session: session)
    }

    override func tearDown() {
        service = nil
        session = nil
        MockURLProtocol.stubbedData = nil
        MockURLProtocol.stubbedResponse = nil
        MockURLProtocol.stubbedError = nil

        super.tearDown()
    }

    // MARK: - Tests

    func test_fetchAllCountries_success_decodesCountries() async throws {
        // GIVEN a valid JSON response
        let json = """
        [
          {
            "name": "Egypt",
            "alpha2Code": "EG",
            "capital": "Cairo",
            "region": "Africa",
            "currencies": [
              { "code": "EGP", "name": "Egyptian pound", "symbol": "£" }
            ],
            "flag": "https://flagcdn.com/eg.svg"
          }
        ]
        """
        MockURLProtocol.stubbedData = json.data(using: .utf8)
        MockURLProtocol.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // WHEN
        let countries = try await service.fetchAllCountries()

        // THEN
        XCTAssertEqual(countries.count, 1)
        let country = countries[0]
        XCTAssertEqual(country.name, "Egypt")
        XCTAssertEqual(country.alpha2Code, "EG")
        XCTAssertEqual(country.capital, "Cairo")
    }

    func test_fetchAllCountries_badStatusCode_throwsBadStatusCode() async {
        // GIVEN a 500 server error
        MockURLProtocol.stubbedData = Data()
        MockURLProtocol.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        // WHEN
        do {
            _ = try await service.fetchAllCountries()
            XCTFail("Expected an error but got success")
        } catch {
            // THEN
            guard case NetworkError.badStatusCode(let code) = error else {
                return XCTFail("Expected NetworkError.badStatusCode, got \(error)")
            }
            XCTAssertEqual(code, 500)
        }
    }
}
