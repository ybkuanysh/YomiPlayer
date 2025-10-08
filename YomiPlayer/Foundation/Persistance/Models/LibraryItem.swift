//
//  VideoItem.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 08.08.2025.
//

import Foundation
import SwiftData

@Model
class LibraryItem {
    @Attribute(.unique)
    var id: UUID = UUID()
    var name: String
    var videoURL: URL
    var subtitlesURL: URL?
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    init(name: String, videoURL: URL, subtitlesURL: URL?) {
        self.name = name
        self.videoURL = videoURL
        self.subtitlesURL = subtitlesURL
    }
}
