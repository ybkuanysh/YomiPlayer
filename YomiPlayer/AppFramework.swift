//
//  AppFramework.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 04.08.2025.
//

import DITranquillity

public final class AppFramework: DIFramework {
    public static func load(container: DITranquillity.DIContainer) {
        container.append(part: LibraryPart.self)
        container.append(part: AddVideoPart.self)
        container.append(part: PersistancePart.self)
    }
}
