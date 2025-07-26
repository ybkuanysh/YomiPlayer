//
//  VideoPlayer.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 24.07.2025.
//

import AVKit
import SwiftUI

struct CustomVideoPlayer: NSViewRepresentable {
    typealias NSViewType = PlayerView

    let player: AVPlayer

    init(player: AVPlayer) {
        self.player = player
    }

    func makeNSView(context: Context) -> PlayerView {
        return PlayerView(player: player)
    }

    func updateNSView(_ nsView: PlayerView, context: Context) {
        // можно обновить player или UI здесь при необходимости
    }
}
