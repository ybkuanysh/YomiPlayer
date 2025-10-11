//
//  PlayerView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var model: PlayerViewModel
    let fileURL: URL

    init(_ libraryItem: LibraryItem) {
        self.fileURL = libraryItem.videoURL
        model = PlayerViewModel(libraryItem: libraryItem)
    }

    var body: some View {

        VStack {
            CustomVideoPlayer(player: model.player)
            VStack {
                ScrollView {
                    ForEach(model.subtitlesText, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue)
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
            HStack{
                Button {
                    self.model.isPlaying.toggle()
                } label: {
                    Image(systemName: self.model.isPlaying ? "pause" : "play")
                        .padding()
                }
                Button {
                    model.parseSubtitles()
                } label: {
                    Text("parse SRT")
                }
            }
        }
    }
}

#Preview {
    let previewFileURL = Bundle.main.url(
        forResource: "video",
        withExtension: "mp4"
    )
    let item = LibraryItem(
        name: "Test Data",
        videoURL: previewFileURL!,
        subtitlesURL: previewFileURL!
    )
    PlayerView(item)
}
