import Foundation
import YomiModels

public enum Destination: Hashable {
    case tab(_ destination: TabDestination)
    case push(_ destination: PushDestination)
    case sheet(_ destination: SheetDestination)
    case fullScreen(_ destination: FullScreenDestination)
}

extension Destination: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .tab(destination): ".tab(\(destination))"
        case let .push(destination): ".push(\(destination))"
        case let .sheet(destination): ".sheet(\(destination))"
        case let .fullScreen(destination): ".fullScreen(\(destination))"
        }
    }
}

// MARK: - Push Destinations

public enum PushDestination: String, Hashable {
    case addVideo
}

// MARK: - Tab Destinations

public enum TabDestination: String, Hashable {
    case library
    case words
    case settings
}

// MARK: - Sheet Destinations

public enum SheetDestination: String, Hashable, Identifiable {
    case dummyDestination
    
    public var id: String {
        switch self {
        case .dummyDestination: ""
        }
    }
}

// MARK: - Full Screen Destinations

public enum FullScreenDestination: Hashable {
    case player(libraryItem: YomiLibraryItem)
}

extension FullScreenDestination: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .player(libraryItem): ".player(\(libraryItem))"
        }
    }
}

extension FullScreenDestination: Identifiable {
    public var id: String {
        switch self {
        case let .player(libraryItem): libraryItem.id.uuidString
        }
    }
}
