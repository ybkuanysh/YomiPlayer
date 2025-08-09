//
//  LibraryItemDataSource.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 08.08.2025.
//

import SwiftData
import Foundation

class LibraryItemDataSource {
    private let contextManager: PersistanceContextManager
    private let context: ModelContext

    init(contextManager: PersistanceContextManager) {
        self.contextManager = contextManager
        self.context = contextManager.context
    }
}

extension LibraryItemDataSource {
    func insert(_ entity: LibraryItem) {
        context.insert(entity)
        applyChanges()
    }
    
    func delete(_ entity: LibraryItem) {
        context.delete(entity)
        applyChanges()
    }
    
    func fetchLibraryItems() -> [LibraryItem] {
        let fetchDescriptor = FetchDescriptor<LibraryItem>(
            sortBy: [SortDescriptor(\.updatedAt, order: .forward)]
        )
        
        var libraryItems: [LibraryItem] = []
        
        do {
            libraryItems = try context.fetch(fetchDescriptor)
        } catch {
            fatalError("Error at fetchLibraryItems(): \(error)")
        }
        
        return libraryItems
    }
    
    private func applyChanges() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error at applyChanges(): \(error)")
            }
        }
    }
}
