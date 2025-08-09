//
//  LibraryVideoItemScreen.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 05.08.2025.
//

import SwiftUI

struct AddVideoScreen: View {
    @Environment(Router.self) private var router
    @State var sheetPresented = false
    @State var selectedURL: URL?

    var body: some View {
        VStack {
            Text(selectedURL?.path() ?? "Choose file")
                .font(.title)
            Button("Select File") {
                sheetPresented = true
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $sheetPresented) {
                DocumentPicker(selectedURL: $selectedURL)
            }
        }
    }
}

#Preview {
    AddVideoScreen()
}
