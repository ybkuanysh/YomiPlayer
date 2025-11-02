// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VideoPlayer",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "VideoPlayer",
            targets: ["VideoPlayer"]
        )
    ],
    dependencies: [
        .package(path: "../1-Base/YomiModels"),
        .package(path: "../1-Base/PreviewData"),
        .package(
            url: "https://github.com/mihai8804858/swift-srt-parser",
            from: "1.0.0"
        ),

    ],
    targets: [
        .target(
            name: "VideoPlayer",
            dependencies: [
                "YomiModels",
                "PreviewData",
                .product(name: "SRTParser", package: "swift-srt-parser"),
            ],
        )

    ]
)
