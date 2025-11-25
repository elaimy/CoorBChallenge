//
//  NetworkError.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case badStatusCode(Int)
    case decodingFailed(Error)
    case noData
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."

        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"

        case .badStatusCode(let statusCode):
            return "Received an unexpected status code: \(statusCode)."

        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"

        case .noData:
            return "No data received from the server."

        case .unknown:
            return "An unknown error occurred."
        }
    }
}
