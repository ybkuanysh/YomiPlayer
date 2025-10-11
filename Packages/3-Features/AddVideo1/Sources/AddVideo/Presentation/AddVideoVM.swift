//
//  AddVideoVM.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 09.08.2025.
//

import Foundation

public final class AddVideoVM: ObservableObject {
    @Published var isSheetPresented = false
    @Published var selectDocumentType: DocumentType = .video
    @Published var selectedVideoURL: URL?
    @Published var selectedSubtitlesURL: URL?
    
    private let dataSource: LibraryItemDataSource
    
    init() {
        self.dataSource = LibraryItemDataSource(contextManager: .shared)
    }

    func selectFile(_ type: DocumentType) {
        selectDocumentType = type
        isSheetPresented = true
    }

    func saveAndContinue(router: Router) {
        guard let url = selectedVideoURL else { return }
        let item = LibraryItem(
            name: url.lastPathComponent,
            videoURL: url,
            subtitlesURL: selectedSubtitlesURL
        )
        dataSource.insert(item)
        router.navigate(to: .fullScreen(.player(libraryItem: item)))
    }
}
