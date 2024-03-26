// The Swift Programming Language
// https://docs.swift.org/swift-book

import Logs

@Logging
struct Cat {
    func meow() {
        Self.logger.log("Meow!")
    }
}
