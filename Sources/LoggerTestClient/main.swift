import Foundation


import Logs

@HasLogger
struct Cat {
    func meow() {
        logger.log("Meow")
    }
}

/// The equivilent implementation to Cat above without macros
struct NotCat {
    func meow() {
        logger.log("Meow")
    }
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? UUID().uuidString,
        category: String(describing: Self.self)
    )
}

Cat().meow()
