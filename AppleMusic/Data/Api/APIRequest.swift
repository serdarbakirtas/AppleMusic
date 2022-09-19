//
//  APIRequest.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

import Foundation

final class APIURLRequest {

    // base url of apple music api
    private let baseURL = URL(string: "https://api.music.apple.com/v1/catalog/de/")!
    
    // Generate Developer Token: https://rudrank.blog/postman-apple-music-api
    private let developerToken = "XXX"

    init() {}
    
    func executeUrlRequest(for request: APIRequestType) throws -> URLRequest {

        // merge base url with path url
        let url = baseURL.appendingPathComponent(request.path)

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw APIError.authenticationError
        }

        urlComponents.queryItems = request.params

        guard let pathURL = urlComponents.url else {
            throw APIError.authenticationError
        }
        
        // create URL request
        var urlRequest = URLRequest(url: pathURL)
        urlRequest.httpMethod = request.method.rawValue

        // header fields
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}
