//
//  GenerateLogger.swift
//  Logs
//
//  Created by Brianna Zamora on 3/23/24.
//

import Foundation
import PackagePlugin

@main
struct GenerateLogger: BuildToolPlugin {
    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) throws -> [Command] {
        guard let target = target.sourceModule else {
            return []
        }
        let outputPath = context.pluginWorkDirectory.appending("Logger.swift")
        return [
            .buildCommand(
                displayName: "Generating Logger in \(target.moduleName)",
                executable: try context.tool(named: "LoggerGenerator").path,
                arguments: [ "\(outputPath)", target.name, context.package.displayName ],
                outputFiles: [ outputPath ]
            )
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension GenerateLogger: XcodeBuildToolPlugin {
    /// This entry point is called when operating on an Xcode project.
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [PackagePlugin.Command] {
        let outputPath = context.pluginWorkDirectory.appending("Logger.swift")
        return [
            .buildCommand(
                displayName: "Generating Logger in \(target.displayName)",
                executable: try context.tool(named: "LoggerGenerator").path,
                arguments: [ "\(outputPath)", target.displayName, context.xcodeProject.displayName ],
                outputFiles: [ outputPath ]
            )
        ]
    }
}
#endif
