// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "PreviewData",
    products: [
        .library(
            name: "PreviewData",
            targets: ["PreviewData"]
        ),
    ],
    targets: [
        .target(
            name: "PreviewData",
            path: "Sources",
            resources: [
                .process("video.mp4"),
                .process("subtitles.srt")
            ]
        ),

    ]
)
