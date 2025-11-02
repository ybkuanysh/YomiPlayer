import Foundation
import SwiftData
import YomiModels

public class YomiLibraryDataSource {
    private let context: ModelContext
    
    public init(context: ModelContext) {
        self.context = context
    }
}

extension YomiLibraryDataSource {
    public func insert(_ entity: YomiLibraryItem) throws {
        context.insert(entity)
        try context.save()
    }

    public func delete(_ entity: YomiLibraryItem) throws {
        context.delete(entity)
        try context.save()
    }
    
    public func fetch() throws -> [YomiLibraryItem] {
//        var fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor(\.updatedAt, order: .forward)])
        let descriptor = FetchDescriptor<YomiLibraryItem>()
        let notes = try context.fetch(descriptor)
        return notes
    }
}
