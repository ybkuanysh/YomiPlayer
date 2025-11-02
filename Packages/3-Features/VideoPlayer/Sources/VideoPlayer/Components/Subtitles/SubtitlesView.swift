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
        ScrollView {
            ForEach(subtitles.data, id: \.counter) { item in
                VStack {
                    Text(item.text)
                        .font(
                            item.start.seconds...item.end.seconds
                            ~= currentTime.seconds ? .title : .subheadline
                        )
                        .background {
                            if item.start.seconds...item.end.seconds
                                ~= currentTime.seconds {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.blue)
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    SubtitlesView(.prevewValue(), at: .init(value: 1, timescale: 1))
}
