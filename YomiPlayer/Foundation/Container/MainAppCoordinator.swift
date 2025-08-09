//
//  Container.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 04.08.2025.
//

import DITranquillity

public class MainAppCoordinator {

    public static let shared: MainAppCoordinator = MainAppCoordinator()
    
    public var container: DIContainer
    
    init() {
        let container = DIContainer()
        container.append(framework: AppFramework.self)
        self.container = container
    }
    
    public func start() {
        print("MainAppCoordinator started")
    }
}
