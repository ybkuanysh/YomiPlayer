//
//  VideoLibraryView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import SwiftUI

struct VideoLibraryView: View {
    @State var currentDir: URL = URL(fileURLWithPath: "")
    @ObservedObject var model = VideoLibraryViewModel(
        dto: DirectoryListingDTO(parent: "", name: "")
    )

    var body: some View {
        VStack {
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
                        HStack {
                            Image(systemName: "doc")
                            Text(entry.name)
                        }
                    }

                }
            }
            .task {
                model.loadLibrary()
            }
            .animation(.default, value: model.entries)
            .navigationTitle("Documents")
            .toolbar {
                Button {
                    model.createFolder("Folder \(Date())")
                } label: {
                    Label("Create folder", systemImage: "folder.badge.plus")
                }
            }
        }
    }
}

#Preview {
    VideoLibraryView()
}
