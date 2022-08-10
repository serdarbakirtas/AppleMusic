//
//  APIRequestType.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

import Foundation

// Parameters and values
protocol APIRequestType {

    var path: String { get }
    var method: HTTPMethod { get }
    var params: [URLQueryItem]? { get }
}

// Generic types
protocol DecodableAPIRequest: APIRequestType {
    associatedtype Response: Decodable
}
typealias CodableAPIRequest = DecodableAPIRequest
