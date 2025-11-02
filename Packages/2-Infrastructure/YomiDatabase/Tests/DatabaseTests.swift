//
//  Test.swift
//  Database
//
//  Created by Kuanysh Yabekov on 27.10.2025.
//

import YomiModels
import SwiftData
import Testing

@testable import YomiDatabase

class MockContextManager {
    private var container: ModelContainer?
    var context: ModelContext?

    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            container = try ModelContainer(
                for: YomiLibraryItem.self,
                configurations: config
            )
            if let container {
                context = ModelContext(container)
            }
        } catch { debugPrint("Error initializing container: \(error)") }
    }
}

@Suite
struct Test {
    private var dataSource: YomiLibraryDataSource!

    init() {
        let contextManager = MockContextManager()
        let context = contextManager.context
        dataSource = YomiLibraryDataSource(context: context!)
    }

    @Test func insertItem() async throws {
        var library: [YomiLibraryItem]
        library = try dataSource.fetch()

        let item = YomiLibraryItem.previewValue()
        try dataSource.insert(item)

        library = try dataSource.fetch()
        #expect(item == library[0])
    }
    
    @Test func deleteItem() async throws {
        var library: [YomiLibraryItem]
        
        let item = YomiLibraryItem.previewValue()
        try dataSource.insert(item)
        
        library = try dataSource.fetch()
        let itemExists = library.contains(where: { $0.id == item.id })
        #expect(itemExists)
        
        try dataSource.delete(item)
        
        library = try dataSource.fetch()
        let itemNotExist = !library.contains(where: { $0.id == item.id })
        #expect(itemNotExist)

    }
    
    @Test func updateItem() async throws {
        var library: [YomiLibraryItem]
        
        let item = YomiLibraryItem.previewValue()
        try dataSource.insert(item)
        
        library = try dataSource.fetch()
        let itemExists = library.contains(where: { $0.id == item.id })
        #expect(itemExists)
        
        item.name = "Updated Name"
        try dataSource.insert(item)
        
        library = try dataSource.fetch()
        let itemUpdated = library.contains(where: { $0.id == item.id && $0.name == "Updated Name" })
        #expect(itemUpdated)
    }

}
