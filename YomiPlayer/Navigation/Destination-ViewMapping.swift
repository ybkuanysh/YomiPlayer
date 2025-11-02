import SwiftUI
import Navigation
import VideoLibrary
import VideoPlayer

@ViewBuilder func view(for destination: PushDestination) -> some View {
    switch destination {
    case .addVideo:
        LibItemCreateScreen()
    }
}

@ViewBuilder func view(for destination: SheetDestination) -> some View {
    Group {
        switch destination {
        case .dummyDestination:
            VStack {}
        }
    }
}

@ViewBuilder func view(for destination: FullScreenDestination) -> some View {
    Group {
        switch destination {
        case let .player(libraryItem):
            PlayerScreen(libraryItem)
        }
    }
    .addDismissButton()
}
