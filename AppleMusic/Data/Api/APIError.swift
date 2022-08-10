//
//  APIError.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

import Foundation

enum APIError: Error {
    case invalidURL

    /// http status code
    case httpCode(HTTPCode)
    
    /// authentication
    case authenticationError

    /// unkowns
    case unexpectedError(message: String)
    case unexpectedResponse(_ : Error)

    /// API response data or mapping errors
    case responseError
    case parseError(_ : Error)
}


// MARK: Message types
extension APIError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .authenticationError:
            return "authenticationError"
        case .unexpectedError(message: let message):
            return message
        case .unexpectedResponse(let errorMessage):
            return errorMessage.localizedDescription
        case .responseError:
            return "responseError"
        case .parseError(let errorMessage):
            return "parseError is \(errorMessage)"
        case .invalidURL:
            return "Invalid URL"
        case let .httpCode(code):
            return "Unexpected HTTP code: \(code)"
        }
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
