//
//  PlayerViewModel.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 25.07.2025.
//

import AVKit
import SRTParser
import YomiModels

class PlayerViewModel: ObservableObject {
    @Published var data: PlayerData = .init()
    let libraryItem: YomiLibraryItem

    private var timeObserverToken: Any?

    init(libraryItem: YomiLibraryItem) {
        self.libraryItem = libraryItem
        
        
        
        let manager = FileManager()
        let bookmarkURL = URL.documentsDirectory.appendingPathComponent("bookmark.txt")
        if !manager.fileExists(atPath: bookmarkURL.path()) {
            guard libraryItem.videoURL.startAccessingSecurityScopedResource() else {
                fatalError("Can't access video URL")
            }
            defer { libraryItem.videoURL.stopAccessingSecurityScopedResource() }
            
            do {
                let bookmark = try libraryItem.videoURL.bookmarkData(
                    options: .minimalBookmark,
                    includingResourceValuesForKeys: nil,
                    relativeTo: nil
                )
                try bookmark.write(to: bookmarkURL)
            } catch {
                fatalError("Can't create bookmark")
            }
        } else {
            do {
                let bookmarkData = try Data(contentsOf: bookmarkURL)
                var isStale = false
                let url = try URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &isStale)
                guard !isStale else { fatalError("Bookmark is stale") }
                
                libraryItem.videoURL = url
            } catch {
                fatalError("Can't read bookmark")
            }
        }
        
        data.player = AVPlayer(
            playerItem: AVPlayerItem(url: libraryItem.videoURL)
        )
        data.currentTime = data.player.currentTime()
        data.duration = CMTime.zero
        addPeriodicTimeObserver()
    }

    func seek(to seconds: Double) {
        let time = CMTime(seconds: seconds, preferredTimescale: 600)
        data.player.seek(to: time)
    }

    private func addPeriodicTimeObserver() {
        // Вызывается каждые 0.1 секунды
        let interval = CMTime(seconds: 0.1, preferredTimescale: 600)
        timeObserverToken = data.player.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            self?.data.currentTime = time
            if let item = self?.data.player.currentItem {
                self?.data.duration = item.duration
            }
        }
    }

    func play() {
        let currentItem = data.player.currentItem
        if currentItem?.currentTime() == currentItem?.duration {
            currentItem?.seek(to: .zero, completionHandler: nil)
        }

        data.player.play()
    }

    func pause() {
        data.player.pause()
    }

    deinit {
        if let token = timeObserverToken {
            data.player.removeTimeObserver(token)
        }
    }

}

extension PlayerViewModel: PlayerActions {
    func togglePlay() {
        data.isPlaying.toggle()
        if data.isPlaying {
            play()
        } else {
            pause()
        }
        return
    }

    func parseSubtitles() {
        guard let fileURL = libraryItem.subtitlesURL else { return }

        let parser = SRTParser()
        let subtitlesRaw: String
        let srt: SRT

//        guard fileURL.startAccessingSecurityScopedResource() else {
//            fatalError("Can't access subtitles URL")
//        }
//        defer { fileURL.stopAccessingSecurityScopedResource() }
        do {
            subtitlesRaw = try String(contentsOf: fileURL, encoding: .utf8)
            srt = try parser.parse(subtitlesRaw)
        } catch { fatalError("Error while trying to parse SRT data") }

        for item in srt.cues {
            var textContent: String = ""

            for component in item.text.components {
                switch component {
                case .plain(let text): textContent.append(text)
                default: fatalError()
                }
            }

            let startTime = CMTime(
                seconds: item.metadata.timing.start.interval,
                preferredTimescale: 1000
            )

            let endTime = CMTime(
                seconds: item.metadata.timing.end.interval,
                preferredTimescale: 1000
            )

            let newElement: Subtitle = .init(
                counter: item.counter,
                start: startTime,
                end: endTime,
                text: textContent
            )

            data.subtitles.data.append(newElement)
        }

    }
}
