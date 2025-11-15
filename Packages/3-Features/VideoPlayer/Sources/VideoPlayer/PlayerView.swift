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
        VStack(spacing: 0) {
            CustomVideoPlayer(player: data.player)
                .aspectRatio(16/9, contentMode: .fit)
            SubtitlesView(data.subtitles, at: data.currentTime)
            HStack {
                Text(data.currentTime.formatted())
                Spacer()
                Text(data.duration.formatted())
            }
            .padding(.horizontal)
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
                Button { actions?.previousSentence() } label: {
                    Image(systemName: "backward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
                Button {
                    actions?.togglePlay()
                } label: {
                    Image(systemName: data.isPlaying ? "pause.fill" : "play.fill")
                        .padding(.horizontal)
                        .background {
                            Circle()
                                .stroke(.blue, lineWidth: 2)
                                .frame(width: 36, height: 36)
                        }
                }
                Button { actions?.nextSentence() } label: {
                    Image(systemName: "forward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
            }
            .padding()
        }
        .onAppear { actions?.parseSubtitles() }
    }
}

#Preview {
    PlayerView(
        data: .init()
    )
}
