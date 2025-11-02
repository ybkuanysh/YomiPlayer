//
//  PlayerView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import PreviewData
import SwiftUI
import YomiModels

struct PlayerView: View {
    var data: PlayerData
    var actions: PlayerActions?

    var body: some View {
        VStack {
            CustomVideoPlayer(player: data.player)
                .aspectRatio(16/9, contentMode: .fit)
            SubtitlesView(data.subtitles, at: data.currentTime)
            Text(
                "Current time: \(data.currentTime.seconds), Duration: \(data.duration.seconds)"
            )
            Slider(
                value: Binding<Double>(
                    get: { data.currentTime.seconds },
                    set: { newValue in actions?.seek(to: newValue) }
                ),
                in:
                    0...(data.duration.seconds.isFinite
                    && data.duration.seconds > 0 ? data.duration.seconds : 1),
            )
            HStack {
                Button {
                    actions?.togglePlay()
                } label: {
                    Image(systemName: data.isPlaying ? "pause" : "play")
                        .padding()
                }
            }
        }
        .onAppear { actions?.parseSubtitles() }
    }
}

#Preview {
    PlayerView(
        data: .init()
    )
}
