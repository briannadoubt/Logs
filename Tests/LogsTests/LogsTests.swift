import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(LogsMacros)
import LogsMacros

let testMacros: [String: Macro.Type] = [
    "Logger": LoggerMacro.self,
]
#endif

final class LogsTests: XCTestCase {
    func testMacro() throws {
        #if canImport(LogsMacros)
        assertMacroExpansion(
            """
            @Logging struct Cat {}
            """,
            expandedSource: """
            @Logging struct Cat {
                private static let logger = Logger(
                    category: String(
                        describing: Self.self
                    )
                )
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
