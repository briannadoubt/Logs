// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Logs",
    platforms: [.macOS(.v13), .iOS(.v16), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16), .visionOS(.v1)],
    products: [
        .library(
            name: "Logs",
            targets: ["Logs"]
        ),
        .plugin(name: "GenerateLogger", targets: ["GenerateLogger"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .upToNextMajor(from: "510.0.1")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "1.3.1")),
    ],
    targets: [
        
        // MARK: Plugin

        .plugin(
            name: "GenerateLogger",
            capability: .buildTool(),
            dependencies: [
                .target(name: "LoggerGenerator")
            ],
            packageAccess: true
        ),

        .executableTarget(
            name: "LoggerGenerator",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),

        // MARK: Macro

        .target(name: "Logs", dependencies: ["LogsMacros"]),

        .macro(
            name: "LogsMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        .testTarget(
            name: "LogsTests",
            dependencies: [
                "LogsMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),

        // MARK: Internal

        .executableTarget(
            name: "LoggerTestClient",
            dependencies: ["Logs"],
            plugins: ["GenerateLogger"]
        )
    ]
)
