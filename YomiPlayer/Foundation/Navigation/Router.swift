//
//  Router.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 01.08.2025.
//

import SwiftUI

@Observable
final class Router {
    let id = UUID()
    let level: Int

    var identifierTab: TabDestination?
    var selectedTab: TabDestination?

    var navigationStackPath: [PushDestination] = []

    var presentingSheet: SheetDestination?

    var presentingFullScreen: FullScreenDestination?

    weak var parent: Router?

    init(level: Int, identifierTab: TabDestination?) {
        self.level = level
        self.identifierTab = identifierTab
    }

    private func resetContent() {
        navigationStackPath = []
        presentingSheet = nil
        presentingFullScreen = nil
    }
}

extension Router {
    func childRouter(for tab: TabDestination? = nil) -> Router {
        let router = Router(
            level: level + 1,
            identifierTab: tab ?? identifierTab
        )
        router.parent = self
        return router
    }
}

extension Router {
    func navigate(to destination: Destination) {
        switch destination {
        case let .tab(tab):
            select(tab: tab)
        case let .push(destination):
            push(destination)
        case let .sheet(destination):
            present(sheet: destination)
        case let .fullScreen(destination):
            present(fullScreen: destination)
        }
    }

    func select(tab destination: TabDestination) {
        if level == 0 {
            selectedTab = destination
        } else {
            parent?.select(tab: destination)
            resetContent()
        }
    }

    func push(_ destination: PushDestination) {
        navigationStackPath.append(destination)
    }

    func present(sheet destination: SheetDestination) {
        presentingSheet = destination
    }

    func present(fullScreen destination: FullScreenDestination) {
        presentingFullScreen = destination
    }
}
