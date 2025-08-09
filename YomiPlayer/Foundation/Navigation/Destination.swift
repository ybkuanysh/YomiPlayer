//
//  Destination.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 01.08.2025.
//

import Foundation

// MARK: - Generic Destinations

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

// MARK: - Tab Destinations

public enum TabDestination: String, Hashable {
    case library
    case words
    case settings
}

// MARK: - Push Destinations

public enum PushDestination: String, Hashable, Identifiable {
    case libraryVideoItem

    public var id: String {
        switch self {
        case .libraryVideoItem: ".libraryVideoItem"
        }
    }
}

// MARK: - Sheet Destinations

public enum SheetDestination: String, Hashable, Identifiable {
    public var id: String {
        switch self {
        case .someDummyDest: ""
        }
    }

    case someDummyDest

}

// MARK: - Full Screen Destinations

public enum FullScreenDestination: Hashable {
    case videoPlayer(videoURL: URL)
}

extension FullScreenDestination: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .videoPlayer(videoURL): ".videoPlayer(\(videoURL))"
        }
    }
}

extension FullScreenDestination: Identifiable {
    public var id: String {
        switch self {
        case let .videoPlayer(videoURL): videoURL.formatted()
        }
    }
}
