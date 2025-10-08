import Foundation

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

public enum PushDestination: String, Hashable {
    case addVideo
}

public enum TabDestination: String, Hashable {
    case library
    case words
    case settings
}

public enum SheetDestination: String, Hashable, Identifiable {
    case dummyDestination
    
    public var id: String {
        switch self {
        case .dummyDestination: ""
        }
    }
}

public enum FullScreenDestination: Hashable {
    case player(videoURL: URL)
}

extension FullScreenDestination: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .player(videoURL): ".player(\(videoURL))"
        }
    }
}

extension FullScreenDestination: Identifiable {
    public var id: String {
        switch self {
        case let .player(videoURL): videoURL.path()
        }
    }
}
