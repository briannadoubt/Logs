// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "LogsDemo",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .macCatalyst(.v16),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "LogsDemo",
            targets: ["LogsDemo"]
        ),
    ],
    dependencies: [
        .package(name: "Logs", path: "../..")
    ],
    targets: [
        .target(
            name: "LogsDemo",
            dependencies: [
                .product(name: "Logs", package: "Logs"),
            ],
            plugins: [
                .plugin(name: "GenerateLogger", package: "Logs")
            ]
        )
    ]
)
