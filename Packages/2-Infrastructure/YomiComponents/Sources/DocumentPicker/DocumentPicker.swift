//
//  File.swift
//  YomiComponents
//
//  Created by Kuanysh Yabekov on 02.11.2025.
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

extension View {
    public func yomiFileImporter(
        isPresented: Binding<Bool>,
        allowedContentTypes: DocumentType,
        onCompletion: @escaping (_ result: Result<URL, any Error>) -> Void
    ) -> some View {
        self
            .sheet(isPresented: isPresented) {
                DocumentPicker(onComplete: onCompletion, contentTypes: allowedContentTypes)
            }
    }
}

public struct DocumentPicker: UIViewControllerRepresentable {
    let onComplete: (_ result: Result<URL, any Error>) -> Void
    let contentTypes: DocumentType

    public init(
        onComplete: @escaping (_ result: Result<URL, any Error>) -> Void,
        contentTypes: DocumentType
    ) {
        self.onComplete = onComplete
        self.contentTypes = contentTypes
    }

    public func makeUIViewController(context: Context) -> some UIViewController
    {
        let controller = UIDocumentPickerViewController(
            forOpeningContentTypes: contentTypes.type
        )
        controller.allowsMultipleSelection = false
        controller.shouldShowFileExtensions = true
        controller.delegate = context.coordinator
        controller.directoryURL = URL.documentsDirectory
        return controller
    }

    public func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {}

    public func makeCoordinator() -> DocumentPickerCoordinator {
        DocumentPickerCoordinator(parent: self)
    }

}

public class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {
    var parent: DocumentPicker

    init(parent: DocumentPicker) {
        self.parent = parent
    }

    public func documentPicker(
        _ controller: UIDocumentPickerViewController,
        didPickDocumentsAt urls: [URL]
    ) {
        guard let url = urls.first else {
            parent.onComplete(
                .failure(
                    NSError(
                        domain: self.debugDescription,
                        code: 0,
                        userInfo: nil
                    )
                )
            )
            return
        }

        parent.onComplete(.success(url))
    }
}
