//
//  APIService.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

import Combine
import Foundation

protocol APIRepo {
    func response<Request: CodableAPIRequest>(from request: Request) -> AnyPublisher<Request.Response, APIError>
}

struct API: APIRepo {

    private let apiUrlRequest: APIURLRequest
    
    init() {
        self.apiUrlRequest = APIURLRequest()
    }
    
    func response<Request: CodableAPIRequest>(from request: Request) -> AnyPublisher<Request.Response, APIError> {

        let urlRequest: URLRequest
        do {
            urlRequest = try apiUrlRequest.executeUrlRequest(for: request)
        } catch {
            let apiError = error as? APIError ?? .unexpectedError(message: error.localizedDescription)
            return Fail(outputType: Request.Response.self, failure: apiError)
                .eraseToAnyPublisher()
        }

        return URLSession.DataTaskPublisher(request: urlRequest, session: URLSession.shared)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    Logger.error(response)
                    throw APIError.responseError
                }
                guard HTTPCodes.success ~= response.statusCode else {
                    Logger.error(response.statusCode)
                    throw APIError.httpCode(response.statusCode)
                }
                return data
            }
            .mapError { error in error as? APIError ?? APIError.unexpectedResponse(error) }
            .decode(type: Request.Response.self, decoder: JSONDecoder())
            .mapError { error in error as? APIError ?? APIError.parseError(error) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
