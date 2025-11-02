// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "VideoLibrary",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "VideoLibrary",
            targets: ["VideoLibrary"]
        )
    ],
    dependencies: [
        .package(path: "../1-Base/YomiModels"),
        .package(path: "../2-Infrastructure/YomiDatabase"),
        .package(path: "../2-Infrastructure/YomiComponents"),
        .package(path: "../2-Infrastructure/Navigation"),
    ],
    targets: [
        .target(
            name: "VideoLibrary",
            dependencies: [
                "YomiModels",
                "Navigation",
                "YomiDatabase",
                "YomiComponents",
            ],
            path: "Sources"
        )

    ]
)
