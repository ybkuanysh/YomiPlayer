//
//  File.swift
//  VideoPlayer
//
//  Created by Kuanysh Yabekov on 29.10.2025.
//

import AVFoundation
import Foundation

struct PlayerData {
    var player: AVPlayer = .init()
    var subtitles: SubtitlesData = .init()
    var currentTime: CMTime = .zero
    var duration: CMTime = .init(value: 14, timescale: 1)
    var isPlaying: Bool = false
}

struct SubtitlesData {
    var data: [Subtitle] = []
}

extension SubtitlesData {
    static func prevewValue() -> SubtitlesData {
        let endTime: CMTime = .init(value: 1, timescale: 1)
        let subtitle = Subtitle(
            counter: 0,
            start: .zero,
            end: endTime,
            text: "Hello World"
        )
        return .init(data: [subtitle])
    }
}

struct Subtitle {
    var counter: Int
    var start: CMTime
    var end: CMTime
    var text: String
}

protocol PlayerActions: AnyObject {
    func togglePlay()
    func seek(to time: Double)
    func parseSubtitles()
}
