//
//  LibraryScreen.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 01.08.2025.
//

import SwiftUI
import DITranquillity

struct LibraryScreen: View {
    
    private let viewModel: LibraryViewModel = MainAppCoordinator.shared.container.resolve()
    
    var body: some View {
        VStack {
            LibraryView(viewModel: viewModel)
        }
        .navigationTitle("Library")
    }
}
