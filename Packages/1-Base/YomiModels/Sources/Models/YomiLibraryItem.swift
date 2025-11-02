//
//  VideoItem.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 08.08.2025.
//

import Foundation
import SwiftData
import PreviewData

public struct Bookmark: Codable {
    public var data: Data
    
    public init(_ data: Data) {
        self.data = data
    }
    
    public static func previewVideo() -> Bookmark {
        return .init(createSecurityScopedResource(with: .previewVideo()!))
    }
    public static func previewSubtitles() -> Bookmark {
        return .init(createSecurityScopedResource(with: .previewSubtitles()!))
    }
    
    private static func createSecurityScopedResource(with url: URL) -> Data {
        guard url.startAccessingSecurityScopedResource() else {
            fatalError("Can't access video URL")
        }
        defer { url.stopAccessingSecurityScopedResource() }

        do {
            return try url.bookmarkData(
                options: .minimalBookmark,
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )
        } catch {
            fatalError("Can't create bookmark")
        }
    }
}

@Model
public class YomiLibraryItem: Identifiable, Hashable {
    @Attribute(.unique)
    public var id: UUID = UUID()
    public var name: String
    public var video: Bookmark
    public var subtitles: Bookmark
    public var createdAt: Date = Date()
    public var updatedAt: Date = Date()

    public init(name: String, video: Bookmark, subtitles: Bookmark) {
        self.name = name
        self.video = video
        self.subtitles = subtitles
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
            video: .previewVideo(),
            subtitles: .previewSubtitles()
        )
    }
}
