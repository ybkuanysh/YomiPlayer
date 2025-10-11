//
//  WordsScreen.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 09.08.2025.
//

import SwiftUI

struct WordsScreen: View {
    var body: some View {
        VStack {
            ContentUnavailableView(
                label: {
                    Label(
                        "Still working on it",
                        systemImage: "questionmark.folder"
                    )
                    .foregroundStyle(.secondary)
                }
            )
        }
        .navigationTitle("Words")
    }
}

#Preview {
    WordsScreen()
}
