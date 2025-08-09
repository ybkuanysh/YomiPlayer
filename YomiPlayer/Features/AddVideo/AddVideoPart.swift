//
//  LibraryVideoItemPart.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 05.08.2025.
//

import DITranquillity

public final class AddVideoPart: DIPart {
    public static func load(container: DITranquillity.DIContainer) {
        container.register(AddVideoScreen.init)
    }
}
