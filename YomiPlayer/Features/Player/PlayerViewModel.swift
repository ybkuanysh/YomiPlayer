//
//  PlayerViewModel.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 25.07.2025.
//

import AVKit

class PlayerViewModel: ObservableObject {

    let player: AVPlayer
    @Published var currentTime: CMTime
    @Published var duration: CMTime
    private var timeObserverToken: Any?

    init(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp4")
        self.player = AVPlayer(playerItem: AVPlayerItem(url: url!))
        self.currentTime = player.currentTime()
        self.duration = CMTime.zero
        addPeriodicTimeObserver()
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
