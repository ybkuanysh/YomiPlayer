//
//  VideoLibraryView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import SwiftUI

struct LibraryView: View {

    @ObservedObject var viewModel: LibraryViewModel

    var body: some View {
        List {
            ForEach(viewModel.videoList, id: \.self) { item in

                NavigationButton(fullScreen: .player(videoURL: item.videoURL)) {
                    HStack {
                        Text(item.name)
                        Spacer()
                        if item.subtitlesURL != nil {
                            Image(systemName: "film.fill")
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "captions.bubble.fill")
                                        .font(.system(size: 12))
                                        .offset(x: 5, y: 5)
                                }
                        } else {
                            Image(systemName: "film.fill")
                        }
                    }
                }
            }
            .onDelete(perform: { index in
                viewModel.didDelete(at: index)
            })
        }
        .onAppear {
            viewModel.updateVideoList()
        }
        .overlay {
            if viewModel.videoList.isEmpty {
                ContentUnavailableView(
                    label: {
                        Label(
                            "No recent files",
                            systemImage: "questionmark.folder"
                        )
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
                NavigationButton(push: .addVideo) {
                    Label("Select File", systemImage: "document.badge.plus")
                }
            }
        }
    }
}
