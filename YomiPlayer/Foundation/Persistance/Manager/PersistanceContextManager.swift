//
//  PersistanceContextManager.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 08.08.2025.
//

import SwiftData

class PersistanceContextManager {
    static let shared = PersistanceContextManager()
    
    let container: ModelContainer
    let context: ModelContext

    private init() {
        do {
            container = try ModelContainer(for: LibraryItem.self)
            context = ModelContext(container)
        } catch {
            fatalError("Error initializing database container: \(error)")
        }
    }
}
