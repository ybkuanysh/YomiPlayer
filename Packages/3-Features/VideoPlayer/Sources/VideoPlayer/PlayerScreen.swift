import PreviewData
import SwiftUI
import YomiModels

public struct PlayerScreen: View {
    @StateObject var viewModel: PlayerViewModel

    public init(_ libraryItem: YomiLibraryItem) {
        _viewModel = .init(wrappedValue: .init(libraryItem: libraryItem))
    }
    public var body: some View {
        PlayerView(
            data: viewModel.data,
            actions: viewModel
        )
    }
}

#Preview {
    PlayerScreen(.previewValue())
}
