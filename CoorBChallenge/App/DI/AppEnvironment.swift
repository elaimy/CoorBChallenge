//
//  AppEnvironment.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import Foundation

struct AppEnvironment {
    
    let countryService: CountryServiceProtocol
    let locationService: LocationServiceProtocol
    let countryStorage: CountryStorageProtocol
    
    
}

extension AppEnvironment {
    static let live = AppEnvironment(
        countryService: CountryService(),
        locationService: LocationService(),
        countryStorage: CountryStorage()
    )
}
