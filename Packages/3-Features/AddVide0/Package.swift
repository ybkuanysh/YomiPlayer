//
//  Package.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 08.10.2025.
//

import PackageDescription

let package = Package(
    name: "AddVideo",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AddVideo",
            targets: ["AddVideo"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AddVideo"),

    ]
)
