//
//  ContentView.swift
//  MacYomiPlayer
//
//  Created by Kuanysh Yabekov on 25.07.2025.
//

import SwiftUI

struct ContentView: View {
    
    let model: PlayerViewModel
    
    init() {
        model = PlayerViewModel(fileName: "video")
    }

    var body: some View {
        VStack {
            CustomVideoPlayer(player: model.player)
        }
    }
}

#Preview {
    ContentView()
}
