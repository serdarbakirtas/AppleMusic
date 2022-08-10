//
//  Logger.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 26.07.22.
//

import Foundation

enum LogEvent: String {
    case error = "[❌]" // error
    case debug = "[💬]" // debug
}

class Logger {

    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    class func error( _ object: Any, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(LogEvent.error.rawValue)line: \(line) column: \(column) function name: \( funcName) -> \(object)")
        }
    }

    class func debug( _ object: Any, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(LogEvent.error.rawValue)line: \(line) column: \(column) function name: \( funcName) -> \(object)")
        }
    }
}
