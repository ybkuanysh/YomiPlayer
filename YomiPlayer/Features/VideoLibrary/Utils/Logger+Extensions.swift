//
//  Logger+Extensions.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import Foundation
import os

extension Logger {
    static let directory = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.yourcompany.YomiPlayer",
        category: "Directory"
    )

    static let player = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.yourcompany.YomiPlayer",
        category: "Player"
    )

    static let network = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.yourcompany.YomiPlayer",
        category: "Network"
    )

    static let ui = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.yourcompany.YomiPlayer",
        category: "UI"
    )
}
