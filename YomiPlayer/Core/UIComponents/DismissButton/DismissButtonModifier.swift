//
//  DismissButtonModifier.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 04.08.2025.
//

import SwiftUI

public struct DismissButtonModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    public func body(content: Content) -> some View {
        content.toolbar {
            Button(action: { dismiss() }) {
                Text("Close")
            }
        }
    }
}

extension View {
    public func addDismissButton() -> some View {
        modifier(DismissButtonModifier())
    }
}
