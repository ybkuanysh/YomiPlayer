import YomiModels
import Foundation
import SwiftData

@MainActor
public final class ContextManager {
    public static var shared = ContextManager()
    public var context: ModelContext?
    private var container: ModelContainer?

    private init() {
        do {
            container = try ModelContainer(for: YomiLibraryItem.self)
            if let container {
                context = container.mainContext
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
