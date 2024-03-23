// The Swift Programming Language
// https://docs.swift.org/swift-book

@_exported import os

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@attached(member, names: named(logger))
public macro Logging() = #externalMacro(module: "LogsMacros", type: "LoggingMacro")
