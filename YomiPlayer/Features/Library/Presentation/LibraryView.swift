//
//  VideoLibraryView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import DITranquillity
import SwiftUI

struct LibraryView: View {
    
    @ObservedObject
    private(set) var viewModel: LibraryViewModel

    var body: some View {
        List {
            ForEach(viewModel.videoList, id: \.self) { item in
                Text(item.name)
            }
            .onDelete(perform: { index in
                viewModel.didDelete(at: index)
            })
        }
        .overlay {
            if viewModel.videoList.isEmpty {
                ContentUnavailableView(
                    label: {
                        Label("No recent files", systemImage: "questionmark.folder")
                            .foregroundStyle(.secondary)
                    }
                )
                .background(
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea()
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationButton(destination: .libraryVideoItem) {
                    Label("Select File", systemImage: "document.badge.plus")
                }
            }
            ToolbarItem {
                Button("Simple item") {
                    viewModel.didCreateVideoItem()
                }
            }
        }
    }
}
