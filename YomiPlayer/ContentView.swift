//
//  ContentView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 24.07.2025.
//

import SwiftUI
import os

private let logger = Logger.ui

struct ContentView: View {
    @State var router: Router = .init(level: 0, identifierTab: nil)

    var body: some View {
        TabView(selection: $router.selectedTab) {
            Tab("Library", systemImage: "tray.full", value: TabDestination.library) {
                NavigationContainer(parentRouter: router) {
                    LibraryScreen()
                }
            }
            Tab("Words", systemImage: "character.book.closed", value: TabDestination.words) {

            }
            Tab("Settings", systemImage: "gearshape", value: TabDestination.settings)
            {

            }
        }
    }
}

#Preview {
    ContentView()
}
