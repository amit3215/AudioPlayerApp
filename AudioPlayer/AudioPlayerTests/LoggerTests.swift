//
//  LoggerTests.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 26/11/2023.
//

import XCTest

final class LoggerTests: XCTestCase {

    var capturedLog: String = ""

    override func setUp() {
        super.setUp()
        capturedLog = ""
        
        // Set the log closure to the testing-specific implementation
        Logger.setTestingLogClosure { (level, message, file, line, function) in
            let logEntry = "\(level.rawValue) [\(file):\(line) - \(function)]: \(message)\n"
            print("Captured Log Entry: \(logEntry)")
            self.capturedLog += logEntry
        }
    }

    override func tearDown() {
        super.tearDown()
        
        // Reset the log closure to the original implementation
        Logger.setTestingLogClosure { (level, message, file, line, function) in
            if level.rawValue == Logger.logLevel.rawValue || level.rawValue == LogLevel.error.rawValue {
                let fileName = (file.description as NSString).lastPathComponent
                let logMessage = "\(level.rawValue) [\(fileName):\(line) - \(function)]: \(message)"
                print(logMessage)
            }
        }
    }
    
    func testLogLevelDebug() {
        Logger.logLevel = .debug
        Logger.log(.debug, "This is a debug message", file: #file, line: #line, function: #function)
        XCTAssertTrue(capturedLog.contains("DEBUG"))
    }
    
    func testLogLevelInfo() {
        Logger.logLevel = .info
        Logger.log(.info, "This is an info message", file: #file, line: #line, function: #function)
        XCTAssertTrue(capturedLog.contains("INFO"))
    }
    
    func testLogLevelWarning() {
        Logger.logLevel = .warning
        Logger.log(.warning, "This is a warning message", file: #file, line: #line, function: #function)
        XCTAssertTrue(capturedLog.contains("WARNING"))
    }
    
    func testLogLevelError() {
        Logger.logLevel = .error
        Logger.log(.error, "This is an error message", file: #file, line: #line, function: #function)
        XCTAssertTrue(capturedLog.contains("ERROR"))
    }
    
    func testLogLevelFiltering() {
        Logger.logLevel = .warning
        Logger.log(.debug, "This is a debug message", file: #file, line: #line, function: #function)
        Logger.log(.info, "This is an info message", file: #file, line: #line, function: #function)
        Logger.log(.warning, "This is a warning message", file: #file, line: #line, function: #function)
        Logger.log(.error, "This is an error message", file: #file, line: #line, function: #function)
        XCTAssertTrue(capturedLog.contains("WARNING"))
        XCTAssertTrue(capturedLog.contains("ERROR"))
    }
}
