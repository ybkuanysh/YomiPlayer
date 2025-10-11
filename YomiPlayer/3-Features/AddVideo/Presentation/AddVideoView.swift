//
//  AddVideoView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 09.08.2025.
//

import SwiftUI

struct AddVideoView: View {
    @ObservedObject var viewModel: AddVideoVM
    @Environment(\.dismiss) private var dismiss
    @Environment(Router.self) private var router

    var body: some View {
        VStack {
            List {
                HStack {
                    Text(viewModel.selectedVideoURL?.lastPathComponent ?? "No video file")
                    Spacer()
                    Button("Select file") {
                        viewModel.selectFile(.video)
                    }
                }
                HStack {
                    Text(viewModel.selectedSubtitlesURL?.lastPathComponent ?? "No subtitle file")
                    Spacer()
                    Button("Select file") {
                        viewModel.selectFile(.subtitle)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        viewModel.saveAndContinue(router: router)
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $viewModel.isSheetPresented) {
                switch viewModel.selectDocumentType {
                case .video:
                    DocumentPicker(
                        selectedURL: $viewModel.selectedVideoURL,
                        contentTypes: viewModel.selectDocumentType
                    )
                case .subtitle:
                    DocumentPicker(
                        selectedURL: $viewModel.selectedSubtitlesURL,
                        contentTypes: viewModel.selectDocumentType
                    )
                case .dictionary:
                    VStack {}
                }
            }
        }
    }
}

#Preview {
    let viewModel = AddVideoVM()
    AddVideoView(viewModel: viewModel)
}
