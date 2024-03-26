import Foundation
import Logs

@Logging
struct Cat {
    func meow() {
        Self.logger.log("Meow")
    }
}

/// The equivilent implementation to Cat above without macros
struct NotCat {
    func meow() {
        Self.logger.log("Meow")
    }
    private static let logger = os.Logger(
        subsystem: Bundle.main.bundleIdentifier ?? UUID().uuidString,
        category: String(describing: Self.self)
    )
}

Cat().meow()
