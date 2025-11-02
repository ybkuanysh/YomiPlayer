//
//  LibraryScreen.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 01.08.2025.
//

import SwiftUI
import YomiDatabase

public struct LibraryScreen: View {
    @StateObject private var viewModel = LibraryViewModel(
        dataSource: .init(context: ContextManager.shared.context!)
    )
    
    public init() {}

    public var body: some View {
        VStack {
            LibraryView(
                library: viewModel.library,
                actions: viewModel
            )
        }
    }
}
