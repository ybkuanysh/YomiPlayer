//
//  SettingsScreen.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 09.08.2025.
//

import SwiftUI

struct SettingsScreen: View {
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
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsScreen()
}
