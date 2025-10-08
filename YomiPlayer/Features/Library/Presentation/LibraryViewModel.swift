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

    init() {
        self.dataSource = LibraryItemDataSource(contextManager: .shared)

        Task { @MainActor in
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
    func updateVideoList() {
        videoList = dataSource.fetchLibraryItems()
    }
}
