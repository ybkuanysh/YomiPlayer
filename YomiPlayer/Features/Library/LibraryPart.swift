//
//  LibraryPart.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 05.08.2025.
//

import DITranquillity

public final class LibraryPart: DIPart {
    public static func load(container: DITranquillity.DIContainer) {
        container.register(LibraryViewModel.init)
        container.register(LibraryView.init(viewModel:))
    }
}
