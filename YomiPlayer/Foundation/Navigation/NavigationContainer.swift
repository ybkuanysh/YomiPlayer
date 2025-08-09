//
//  NavigationContainer.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 01.08.2025.
//

import DITranquillity
import SwiftUI

struct NavigationContainer<Content: View>: View {
    @State var router: Router
    @ViewBuilder var content: () -> Content

    init(
        parentRouter: Router,
        tab: TabDestination? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._router = .init(initialValue: parentRouter.childRouter(for: tab))
        self.content = content
    }

    var body: some View {
        InnerRouter(router: router) {
            content()
        }
        .environment(router)
    }

}

struct InnerRouter<Content: View>: View {
    @Bindable var router: Router
    @ViewBuilder var content: () -> Content

    var body: some View {
        NavigationStack(path: $router.navigationStackPath) {
            content()
                .navigationDestination(for: PushDestination.self) {
                    destination in
                    view(for: destination)
                }
        }
        .sheet(item: $router.presentingSheet) { sheet in
            navigationView(for: sheet, from: router)
        }
        .fullScreenCover(item: $router.presentingFullScreen) { fullScreen in
            navigationView(for: fullScreen, from: router)
        }
    }

    @ViewBuilder func navigationView(
        for destination: SheetDestination,
        from router: Router
    ) -> some View {
        NavigationContainer(parentRouter: router) { view(for: destination) }
    }

    @ViewBuilder func navigationView(
        for destination: FullScreenDestination,
        from router: Router
    ) -> some View {
        NavigationContainer(parentRouter: router) { view(for: destination) }
    }
}
