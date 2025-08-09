//
//  NavigationButton.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 01.08.2025.
//

import SwiftUI

struct NavigationButton<Content: View>: View {
    let destination: Destination
    @ViewBuilder var content: () -> Content
    @Environment(Router.self) private var router
    
    public init(
        destination: Destination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = destination
        self.content = content
    }
    
    public init(
        destination: PushDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .push(destination)
        self.content = content
    }
    
    public init(
        destination: SheetDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .sheet(destination)
        self.content = content
    }
    public init(
        destination: FullScreenDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .fullScreen(destination)
        self.content = content
    }
    
    var body: some View {
        Button(action: { router.navigate(to: destination) }) {
            content()
        }
    }
    
}
