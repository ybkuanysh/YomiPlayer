// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "YomiComponents",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "YomiComponents",
            targets: ["YomiComponents"]),
    ],
    targets: [
        .target(
            name: "YomiComponents",
            path: "Sources"
        ),

    ]
)
