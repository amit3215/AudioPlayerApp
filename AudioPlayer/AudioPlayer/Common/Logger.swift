//
//  Logger.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 25/11/2023.
//

import Foundation

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

struct Logger {
    static var logLevel: LogLevel = .debug

    // Define a closure-based logging mechanism
    private static var logClosure: ((_ level: LogLevel, _ message: String, _ file: StaticString, _ line: UInt, _ function: StaticString) -> Void) = { level, message, file, line, function in
        if level.rawValue == logLevel.rawValue || level.rawValue == LogLevel.error.rawValue {
            let fileName = (file.description as NSString).lastPathComponent
            let logMessage = "\(level.rawValue) [\(fileName):\(line) - \(function)]: \(message)"
            print(logMessage)
            // You can customize this to write logs to a file, send to a server, etc.
        }
    }

    static func log(_ level: LogLevel, _ message: String, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {
        logClosure(level, message, file, line, function)
    }

    // For testing, set the log closure to the testing-specific implementation
    static func setTestingLogClosure(_ closure: @escaping (_ level: LogLevel, _ message: String, _ file: StaticString, _ line: UInt, _ function: StaticString) -> Void) {
        logClosure = closure
    }
}
