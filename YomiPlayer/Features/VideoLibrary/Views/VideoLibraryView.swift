//
//  VideoLibraryView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import SwiftUI

struct VideoLibraryView: View {

    @ObservedObject var model = VideoLibraryViewModel()
    let dto: DirectoryListingDTO
    let root: String
    private let viewTitle: String

    init(dto: DirectoryListingDTO) {
        self.dto = dto
        root = dto.name == "/" ? "" : dto.parent + "/"
        viewTitle = dto.name == "" ? "Documents" : dto.name
        model.entries = []
    }

    var body: some View {
        List {
            ForEach(model.entries) { entry in
                if entry.isDir {
                    NavigationLink(
                        value: DirectoryListingDTO(
                            parent: root + dto.name,
                            name: entry.name
                        )
                    ) {
                        HStack {
                            Image(systemName: "folder")
                            Text(entry.name)
                        }
                    }
                } else {
                    NavigationLink(
                        destination: PlayerView(
                            URL(
                                fileURLWithPath: root + dto.name + "/"
                                    + entry.name
                            )
                        )
                    ) {
                        HStack {
                            Image(systemName: "doc")
                            Text(entry.name)
                        }
                    }
                }
            }
        }
        .navigationTitle(viewTitle)
        .task {
            let previewFileURL = Bundle.main.url(
                forResource: "video",
                withExtension: "mp4"
            )
            print("Test file path: \(previewFileURL?.path())")
            do {
                let path = root + dto.name
                let manager = FileManager.default
                let contents = try manager.contentsOfDirectory(atPath: path)
                let entries = contents.map {
                    var isDir: ObjCBool = false
                    manager.fileExists(
                        atPath: path + "/" + $0,
                        isDirectory: &isDir
                    )
                    return DirectoryEntry(name: $0, isDir: isDir.boolValue)
                }
                let folders = entries.filter { $0.isDir }
                let files = entries.filter { !$0.isDir }
                var items = folders
                items.append(contentsOf: files)
                self.model.entries = items
            } catch {
                print(error)
            }
        }
    }
}
