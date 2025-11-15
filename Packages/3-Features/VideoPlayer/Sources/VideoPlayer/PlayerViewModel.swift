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

        let videoURL = getURL(from: libraryItem.video)
        data.player = AVPlayer(playerItem: AVPlayerItem(url: videoURL))
        data.currentTime = data.player.currentTime()
        data.duration = CMTime.zero
        addPeriodicTimeObserver()
    }

    func seek(to seconds: Double) {
        let time = CMTime(seconds: seconds, preferredTimescale: 600)
        data.player.seek(to: time)
    }

    private func getURL(from bookmark: Bookmark) -> URL {
        do {
            var isStale = false
            let url = try URL(
                resolvingBookmarkData: bookmark.data,
                bookmarkDataIsStale: &isStale
            )
            guard !isStale else { fatalError("Bookmark is stale") }
            return url
        } catch {
            fatalError("Can't read bookmark")
        }
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
    func nextSentence() {
        guard let nextSubtitle = getNextSubtitle(after: data.currentTime) else {
            return
        }
        printCurrentSubtitle(nextSubtitle)
        let timecode = nextSubtitle.start.convertScale(
            600,
            method: .roundTowardZero
        )
        data.player.seek(
            to: timecode,
            toleranceBefore: .zero,
            toleranceAfter: .init(seconds: 0.5, preferredTimescale: 600)
        )
    }

    func previousSentence() {
        guard let prevSubtitle = getPreviousSubtitle(before: data.currentTime)
        else { return }
        printCurrentSubtitle(prevSubtitle)
        let timecode = prevSubtitle.start.convertScale(
            600,
            method: .roundTowardZero
        )
        data.player.seek(
            to: timecode,
            toleranceBefore: .zero,
            toleranceAfter: .init(seconds: 0.5, preferredTimescale: 600)
        )
    }

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
        let fileURL = getURL(from: libraryItem.subtitles)
        let parser = SRTParser()
        let subtitlesRaw: String
        let srt: SRT

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

extension PlayerViewModel {
    private func getNextSubtitle(after time: CMTime) -> Subtitle? {
        let curSubtitleIdx = data.subtitles.data.firstIndex { subtitle in
            subtitle.start.seconds..<subtitle.end.seconds ~= time.seconds
        }
        guard let curSubtitleIdx else { return nil }
        let nextIdx = curSubtitleIdx + 1
        if nextIdx >= data.subtitles.data.count { return nil }
        return data.subtitles.data[nextIdx]
    }

    private func printCurrentSubtitle(_ subtitle: Subtitle) {
        print(
            "\(subtitle.start.seconds) --> \(subtitle.end.seconds): \(subtitle.text)"
        )
    }

    private func getPreviousSubtitle(before time: CMTime) -> Subtitle? {
        let curSubtitleIdx = data.subtitles.data.firstIndex { subtitle in
            subtitle.start.seconds..<subtitle.end.seconds ~= time.seconds
        }
        guard let curSubtitleIdx else { return nil }
        let prevIdx = curSubtitleIdx - 1
        if prevIdx < 0 { return nil }
        return data.subtitles.data[prevIdx]
    }
}
