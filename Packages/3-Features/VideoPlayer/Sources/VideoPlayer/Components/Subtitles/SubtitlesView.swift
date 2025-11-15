//
//  SwiftUIView.swift
//  VideoPlayer
//
//  Created by Kuanysh Yabekov on 29.10.2025.
//

import AVFoundation
import SwiftUI

struct SubtitlesView: View {

    var subtitles: SubtitlesData
    var currentTime: CMTime

    init(_ subtitles: SubtitlesData, at currentTime: CMTime) {
        self.subtitles = subtitles
        self.currentTime = currentTime
    }

    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 10) {
                List(subtitles.data, id: \.counter) { item in
                    sentenceView(item)
                }
                .listStyle(.plain)
            }
            .onChange(of: currentTime) {
                withAnimation {
                    let subIdx = getCurrentSubIndex() ?? 0
                    proxy.scrollTo(subIdx, anchor: .center)
                }
            }
        }
    }
}

// MARK: - Additional UI functions

extension SubtitlesView {
    private func fontStyle(at time: CMTime, of item: Subtitle) -> Font {
        item.start.seconds..<item.end.seconds
            ~= time.seconds ? .title : .subheadline
    }

    private func isSelected(_ item: Subtitle) -> Bool {
        item.start.seconds..<item.end.seconds ~= currentTime.seconds
    }

    private func getCurrentSubIndex() -> Int? {
        subtitles.data.first(where: { isSelected($0) })?.counter
    }

    @ViewBuilder
    func sentenceView(_ item: Subtitle) -> some View {
        VStack {
            Text(item.text)
                .font(fontStyle(at: currentTime, of: item))
        }
        .listRowBackground(isSelected(item) ? Color.blue : Color.clear)
    }

}

struct OffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static let defaultValue: Value = 0.0

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }

}

// MARK: - Preview

#Preview {
    SubtitlesView(.prevewValue(), at: .init(value: 1, timescale: 1))
}
