//
//  Destination-ViewMapping.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 01.08.2025.
//

import SwiftUI

@ViewBuilder func view(for destination: PushDestination) -> some View {
    Group {
        switch destination {
        case .libraryVideoItem:
            AddVideoScreen()
        }
    }
}

@ViewBuilder func view(for destination: SheetDestination) -> some View {
    Group {
    }
}

@ViewBuilder func view(for destination: FullScreenDestination) -> some View {
    Group {
        switch destination {
        case let .videoPlayer(videoURL):
            PlayerView(videoURL)
        }
    }
    .addDismissButton()
    .presentationBackground(.black)
}
