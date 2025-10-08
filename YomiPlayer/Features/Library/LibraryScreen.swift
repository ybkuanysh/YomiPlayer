//
//  LibraryScreen.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 01.08.2025.
//

import SwiftUI

struct LibraryScreen: View {
    @StateObject var viewModel = LibraryViewModel()
    
    var body: some View {
        VStack {
            LibraryView(viewModel: viewModel)
        }
        .navigationTitle("Library")
    }
}
