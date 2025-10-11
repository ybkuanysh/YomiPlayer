//
//  LibraryVideoItemScreen.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 05.08.2025.
//

import SwiftUI

struct AddVideoScreen: View {
    @StateObject private var viewModel = AddVideoVM()
    
    var body: some View {
        AddVideoView(viewModel: viewModel)
    }
}

#Preview {
    AddVideoScreen()
}
