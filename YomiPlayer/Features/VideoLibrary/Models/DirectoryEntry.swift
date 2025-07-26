//
//  DirectoryEntry.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import Foundation

struct DirectoryEntry: Identifiable, Hashable {
    let id: UUID
    let name: String
    var isDir: Bool

    init(name: String, isDir: Bool) {
        id = UUID()
        self.name = name
        self.isDir = isDir
    }
}
