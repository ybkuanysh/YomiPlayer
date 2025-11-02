// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "YomiModels",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "YomiModels",
            targets: ["YomiModels"]
        )
    ],
    dependencies: [
        .package(path: "./PreviewData")
    ],
    targets: [
        .target(
            name: "YomiModels",
            dependencies: ["PreviewData"],
            path: "Sources"
        )
    ]
)
