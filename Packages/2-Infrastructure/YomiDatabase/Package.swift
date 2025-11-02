// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YomiDatabase",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "YomiDatabase",
            targets: ["YomiDatabase"]
        )
    ],
    dependencies: [
        .package(path: "../1-Base/YomiModels"),
    ],
    targets: [
        .target(
            name: "YomiDatabase",
            dependencies: ["YomiModels"],
            path: "Sources"
        ),
        .testTarget(
            name: "YomiDatabaseTests",
            dependencies: ["YomiDatabase"]
            
        ),
    ]
)
