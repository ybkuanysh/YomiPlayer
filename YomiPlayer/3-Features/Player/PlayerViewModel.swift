//
//  PlayerViewModel.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 25.07.2025.
//

import AVKit
import SRTParser

class PlayerViewModel: ObservableObject {

    let player: AVPlayer
    @Published var currentTime: CMTime
    @Published var duration: CMTime
    @Published var subtitlesText: [String] = []
    private var timeObserverToken: Any?
    let libraryItem: LibraryItem

    init(libraryItem: LibraryItem) {
        self.libraryItem = libraryItem
        self.player = AVPlayer(
            playerItem: AVPlayerItem(url: libraryItem.videoURL)
        )
        self.currentTime = player.currentTime()
        self.duration = CMTime.zero
        addPeriodicTimeObserver()
    }

    func parseSubtitles() {
        let fileURL = libraryItem.subtitlesURL!
        let parser = SRTParser()
        let subtitlesRaw: String
        let srt: SRT
        do {
            subtitlesRaw = try String(contentsOf: fileURL, encoding: .utf8)
            srt = try parser.parse(subtitlesRaw)
        } catch {
            fatalError("Error while trying to parse SRT data")
        }
        for item in srt.cues {
            for component in item.text.components {

                switch component {
                case .plain(let text):
                    subtitlesText.append(text)
                default:
                    fatalError()
                }
            }

        }
    }

    @Published var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                play()
            } else {
                pause()
            }
        }
    }
    func seek(to seconds: Double) {
        let time = CMTime(seconds: seconds, preferredTimescale: 600)
        player.seek(to: time)
    }

    private func addPeriodicTimeObserver() {
        // Вызывается каждые 0.1 секунды
        let interval = CMTime(seconds: 0.1, preferredTimescale: 600)
        timeObserverToken = player.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            self?.currentTime = time
            if let item = self?.player.currentItem {
                self?.duration = item.duration
            }
        }
    }

    func play() {
        let currentItem = player.currentItem
        if currentItem?.currentTime() == currentItem?.duration {
            currentItem?.seek(to: .zero, completionHandler: nil)
        }

        player.play()
    }

    func pause() {
        player.pause()
    }

    deinit {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
        }
    }

}
