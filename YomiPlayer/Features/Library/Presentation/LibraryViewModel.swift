//
//  LibraryViewModel.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 05.08.2025.
//

import Foundation

final public class LibraryViewModel: ObservableObject {
    private let dataSource: LibraryItemDataSource
    @Published var videoList: [LibraryItem] = []

    init(dataSource: LibraryItemDataSource) {
        self.dataSource = dataSource

        Task { @MainActor in
            videoList = dataSource.fetchLibraryItems()
        }
    }

    func didCreateVideoItem() {
        Task { @MainActor in
            let item = LibraryItem(name: "New item")
            dataSource.insert(item)
            updateVideoList()
        }
    }
    
    func didDelete(at offsets: IndexSet) {
        Task {@MainActor in
            offsets.forEach { index in
                let item = videoList[index]
                dataSource.delete(item)
            }
            updateVideoList()
        }
    }

    @MainActor
    private func updateVideoList() {
        videoList = dataSource.fetchLibraryItems()
    }
}
