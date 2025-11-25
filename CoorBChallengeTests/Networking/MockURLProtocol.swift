//
//  MockURLProtocol.swift
//  CoorBChallengeTests
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

final class MockURLProtocol: URLProtocol {

    static var stubbedData: Data?
    static var stubbedResponse: URLResponse?
    static var stubbedError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let error = MockURLProtocol.stubbedError {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = MockURLProtocol.stubbedResponse {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let data = MockURLProtocol.stubbedData {
                client?.urlProtocol(self, didLoad: data)
            }

            client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() { }
}
