import SwiftUI
import OSLog

/// A way to specify navigation
@Observable
public final class Router {
    let id = UUID()
    let level: Int

    /// Specifies which tab the router was build for
    public let identifierTab: TabDestination?

    /// Only relevant for the `level 0` root router. Defines the tab to select
    public var selectedTab: TabDestination?

    /// Values presented in the navigation stack
    public var navigationStackPath: [PushDestination] = []

    /// Current presented sheet
    public var presentingSheet: SheetDestination?

    /// Current presented full screen
    public var presentingFullScreen: FullScreenDestination?

    /// Reference to the parent router to form a hierarchy
    /// Router levels increase for the children
    weak var parent: Router?

    /// A way to track which router is visible/active
    /// Used for deep link resolution
    private(set) var isActive: Bool = false

    public init(level: Int, identifierTab: TabDestination?) {
        self.level = level
        self.identifierTab = identifierTab
        self.parent = nil

    }


    private func resetContent() {
        navigationStackPath = []
        presentingSheet = nil
        presentingFullScreen = nil
    }
}

// MARK: - Router Management

public extension Router {
    func childRouter(for tab: TabDestination? = nil) -> Router {
        let router = Router(level: level + 1, identifierTab: tab ?? identifierTab)
        router.parent = self
        return router
    }

    func setActive() {
        parent?.resignActive()
        isActive = true
    }

    func resignActive() {
        isActive = false
        parent?.setActive()
    }

    static func previewRouter() -> Router {
        Router(level: 0, identifierTab: nil)
    }
}

// MARK: - Navigation

public extension Router {
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

    func deepLinkOpen(to destination: Destination) {
        guard isActive else { return }

        navigate(to: destination)
    }
}

extension Router: CustomDebugStringConvertible {
    public var debugDescription: String {
        "Router[\(shortId) - \(identifierTabName) - Level: \(level)]"
    }

    private var shortId: String { String(id.uuidString.split(separator: "-").first ?? "") }

    private var identifierTabName: String {
        identifierTab?.rawValue ?? "No Tab"
    }
}
