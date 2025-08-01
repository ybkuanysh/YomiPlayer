//
//  ContentView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 24.07.2025.
//

import AVKit
import SwiftUI
import os

private let logger = Logger.ui

struct ContentView: View {
    private let manager = FileManager.default
    private var documentDir: URL? {
        manager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    var body: some View {
        NavigationStack {
            VideoLibraryView(dto: .init(parent: documentDir!.path(), name: ""))
                .navigationDestination(for: DirectoryListingDTO.self) {
                    dto in VideoLibraryView(dto: dto)
                }
        }
    }
}

#Preview {
    ContentView()
}
