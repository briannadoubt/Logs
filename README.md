# Logs
Exposes an opinionated `os.Logger` through Swift Package Plugins and Swift Macros

## Installation

### Add to Swift Package

1. Assure that your supported platforms are compatible:
```swift
let package = Package(
    // ...
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .macCatalyst(.v16),
        .visionOS(.v1)
    ],
    // ...
)
```
2. Add `Logs` to your dependencies:
```swift
let package = Package(
    // ...
    dependencies: [
        .package(name: "Logs", url: "https://github.com/briannadoubt/Logs"),
    ],
    // ...
)
```
3. Add `Logs` library dependency and `GenerateLogger` plugin to your target:
```swift
let package = Package(
    // ...
    targets: [
        .target(
            name: "CatsAreCool",
            dependencies: [
                .product(name: "Logs", package: "Logs"),
            ],
            plugins: [
                .plugin(name: "GenerateLogger", package: "Logs")
            ]
        )
    ]
    // ...
)
```
4. Build your project and trust the macro execution in Xcode

### Add to Xcode Project

1. Add `Logs` to your Swift Package Dependencies in Xcode
2. Add `Logs` library to your "Frameworks, Libraries, and Embedded Content" section.
3. Navigate to Project -> Target -> Build Phases -> Run Build Tool Plug-ins and add `GenerateLogger (Logs)`
4. Build your project and trust the macro execution in Xcode

## Usage

Add the `@Logging` attribute to your declaration and a new `os.Logger` static instance is generated on your object:
```swift
import Logs

@Logging
struct Cat {
    func meow() {
        Self.logger.log("Meow!")
    }
}
```

Simply use it by calling:
```swift
Self.logger.log("Meow!")
```

## os.Logger

For more information about Apple's `os.Logger`, check out their documentation [https://developer.apple.com/documentation/os/logger](here).
