//
//  VideoItem.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 08.08.2025.
//

import Foundation
import SwiftData
import PreviewData

@Model
public class YomiLibraryItem: Identifiable, Hashable {
    @Attribute(.unique)
    public var id: UUID = UUID()
    public var name: String
    public var videoURL: URL
    public var subtitlesURL: URL?
    public var createdAt: Date = Date()
    public var updatedAt: Date = Date()

    public init(name: String, videoURL: URL, subtitlesURL: URL?) {
        self.name = name
        self.videoURL = videoURL
        self.subtitlesURL = subtitlesURL
    }

    public static func == (lhs: YomiLibraryItem, rhs: YomiLibraryItem) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension YomiLibraryItem {
    public static func previewValue() -> YomiLibraryItem {
        return .init(
            name: "No title - Reol",
            videoURL: .previewVideo()!,
            subtitlesURL: .previewSubtitles()!
        )
    }
}
