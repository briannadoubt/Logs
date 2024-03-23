import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Adds a module-specific logger to your object
///
///     @HasLogger struct Cat {}
///
///  will expand to
///
///     @HasLogger struct Cat {
///         private let logger = Logger(
///             category: String(
///                 describing: Self.self
///             )
///         )
///     }
public struct HasLoggerMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        return [
            DeclSyntax(
                """
                private let logger = Logger(
                    category: String(
                        describing: Self.self
                    )
                )
                """
            )
        ]
    }
}

@main
struct LogsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        HasLoggerMacro.self,
    ]
}
