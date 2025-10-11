//
//  VideoPlayer.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 24.07.2025.
//

import AVKit
import SwiftUI

struct CustomVideoPlayer: UIViewRepresentable {
    typealias UIViewType = VideoPlayerView

    let player: AVPlayer

    init(player: AVPlayer) {
        self.player = player
    }

    func makeUIView(context: Context) -> VideoPlayerView {
        return VideoPlayerView(player: player)
    }

    func updateUIView(_ uiView: VideoPlayerView, context: Context) {}
}
