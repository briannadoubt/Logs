import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Adds a module-specific logger to your object
///
///     @Logging struct Cat {}
///
///  will expand to
///
///     @Logging struct Cat {
///         private static let logger = Logger(
///             category: String(
///                 describing: Self.self
///             )
///         )
///     }
public struct LoggingMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let name = declaration.as(StructDeclSyntax.self)?.name ?? declaration.as(ClassDeclSyntax.self)?.name ?? declaration.as(ActorDeclSyntax.self)?.name ?? declaration.as(EnumDeclSyntax.self)?.name else {
            throw LoggingMacroExpansionError.failedToExpandTypeDeclarationName
        }
        return [
            DeclSyntax(
                """
                private static let logger = os.Logger(category: String(describing: \(name.trimmed).self))
                """
            )
        ]
    }
}

@main
struct LogsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        LoggingMacro.self,
    ]
}

enum LoggingMacroExpansionError: Error {
    case failedToExpandTypeDeclarationName
}
