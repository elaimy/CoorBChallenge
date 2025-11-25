//
//  InfoRow.swift
//  CoorBChallenge
//
//  Created by Ahmed Elelaimy on 25/11/2025.
//

import SwiftUI

struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(title):")
                .font(.headline)
                .foregroundColor(.secondary)

            Spacer(minLength: 12)

            Text(value)
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
    }
}
