//
//  CountryFlagView.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct CountryFlagView: View {
    let flagURLString: String?

    var body: some View {
        Group {
            if let urlString = flagURLString,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Color.gray.opacity(0.2)
                    }
                }
            } else {
                Color.gray.opacity(0.2)
            }
        }
        .frame(width: 40, height: 26)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
        )
    }
}
