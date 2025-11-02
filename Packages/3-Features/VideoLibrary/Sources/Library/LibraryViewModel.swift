//
//  LibraryViewModel.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 05.08.2025.
//

import Foundation
import YomiModels
import YomiDatabase

class LibraryViewModel: ObservableObject {
    let dataSource: YomiLibraryDataSource
    @Published var library: [YomiLibraryItem] = []
    
    init(dataSource: YomiLibraryDataSource) {
        self.dataSource = dataSource
    }
}

extension LibraryViewModel: LibraryActions {
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = library[index]
            do { try dataSource.delete(item) }
            catch { fatalError("Error while trying to delete library item from db") }
        }
        loadLibrary()
    }
    
    func loadLibrary() {
        do { library = try dataSource.fetch() } catch {
            fatalError("Error while trying to fetch library")
        }
    }
}
