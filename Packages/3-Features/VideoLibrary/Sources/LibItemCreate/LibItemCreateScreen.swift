import SwiftUI
import YomiDatabase
import Navigation

public struct LibItemCreateScreen: View {
    @StateObject var viewModel: LibItemCreateViewModel
    @Environment(Router.self) var router

    public init() {
        let context = ContextManager.shared.context!
        _viewModel = .init(
            wrappedValue: .init(
                dataSource: .init(context: context)
            )
        )
    }

    public var body: some View {
        LibItemCreateView(
            data: $viewModel.data,
            actions: viewModel
        )
        .onAppear {
            viewModel.router = self.router
        }
    }
}

#Preview {
    LibItemCreateScreen()
        .environment(Router.previewRouter())
}
