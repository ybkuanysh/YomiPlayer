//
//  ContentView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 24.07.2025.
//

import AVKit
import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationSplitView {
            VideoLibraryView()
        } detail: {
            Text("Main app view")
        }
    }
}

#Preview {
    ContentView()
}
