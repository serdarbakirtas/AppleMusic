//
//  MockedNetworkProvider.swift
//  AppleMusicTests
//
//  Created by Hasan Bakirtas on 26.07.22.
//

import Combine
import XCTest
@testable import AppleMusic

public class MockedNetworkProvider: APIRepo {

    public var isApiError = false
    public var urlResponse = HTTPURLResponse()
    
    public func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIError> where Request : DecodableAPIRequest {
        
        let future = Future<Request.Response, APIError> { promise in

            if self.isApiError {
                return promise(.failure(APIError.httpError(status: self.urlResponse.statusCode)))
            }

            if let url = Bundle.main.url(forResource: "charts", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Request.Response.self, from: data)
                    
                    return promise(.success(jsonData))
                } catch {
                    print("error:\(error)")
                }
            }
        }
        return future.eraseToAnyPublisher()
    }
}
