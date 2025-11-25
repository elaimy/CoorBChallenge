//
//  CoorBChallengeApp.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

@main
struct CoorBChallengeApp: App {

    private let env = AppEnvironment.live

    var body: some Scene {
        WindowGroup {
            CountryListView(
                viewModel: CountryListViewModel(
                    countryService: env.countryService,
                    locationService: env.locationService,
                    storage: env.countryStorage,
                    defaultCountryCode: "EG"
                )
            )
        }
    }
}
