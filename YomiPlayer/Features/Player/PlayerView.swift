//
//  PlayerView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var model: PlayerViewModel

    init() {
        model = PlayerViewModel(fileName: "video")
    }

    var body: some View {

        VStack {
            CustomVideoPlayer(player: model.player)
            Text(
                "Current time: \(model.currentTime.seconds), Duration: \(model.duration.seconds)"
            )
            Slider(
                value: Binding<Double>(
                    get: { model.currentTime.seconds },
                    set: { newValue in
                        model.seek(to: newValue)
                    }
                ),
                in:
                    0...(model.duration.seconds.isFinite
                    && model.duration.seconds > 0 ? model.duration.seconds : 1),
            )
            Button {
                self.model.isPlaying.toggle()
            } label: {
                Image(systemName: self.model.isPlaying ? "pause" : "play")
                    .padding()
            }
        }
    }
}

#Preview {
    PlayerView()
}
