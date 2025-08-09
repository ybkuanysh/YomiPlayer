//
//  PersistancePart.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 08.08.2025.
//

import DITranquillity

public final class PersistancePart: DIPart {
    public static func load(container: DITranquillity.DIContainer) {
        container.register(PersistanceContextManager.init).lifetime(.single)
        container.register(LibraryItemDataSource.init)
    }
}
