//
//  DocumentPicker.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 03.08.2025.
//

import SwiftUI
import UniformTypeIdentifiers

public enum DocumentType {
    case video
    case subtitle
    case dictionary
    
    var type: [UTType] {
        switch self {
        case .video: [.mpeg4Movie]
        case .subtitle: [.item]
        case .dictionary: [.item]
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedURL: URL?
    let contentTypes: DocumentType
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIDocumentPickerViewController(
            forOpeningContentTypes: contentTypes.type
        )
        controller.allowsMultipleSelection = false
        controller.shouldShowFileExtensions = true
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {}

    func makeCoordinator() -> DocumentPickerCoordinator {
        DocumentPickerCoordinator(parent: self)
    }

}

class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {
    var parent: DocumentPicker

    init(parent: DocumentPicker) {
        self.parent = parent
    }

    func documentPicker(
        _ controller: UIDocumentPickerViewController,
        didPickDocumentsAt urls: [URL]
    ) {
        guard let url = urls.first else { return }
        
        DispatchQueue.main.async {
            self.parent.selectedURL = url
        }
    }
}
