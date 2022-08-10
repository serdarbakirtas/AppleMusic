//
//  ChartsSongListRepository.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

import Foundation

public enum ChartsSongListRepository {
    case getSongList(offset: Int)
}

struct StandartChartsSongListRepository: CodableAPIRequest {

    typealias Response = Charts
    
    var apiRepo: ChartsSongListRepository
    
    init(apiRepo: ChartsSongListRepository) {
        self.apiRepo = apiRepo
    }

    /// set path url
    var path: String {
        switch apiRepo {
            case .getSongList:
                return "charts"
        }
    }

    /// get method
    var method: HTTPMethod {
        switch apiRepo {
            case .getSongList:
                return .get
        }
    }

    /// set query items (parameters)
    var params: [URLQueryItem]? {
        switch apiRepo {
            case .getSongList(offset: let offset):
                let queryItems = [
                    URLQueryItem(name: "limit", value: "20"),
                    URLQueryItem(name: "types", value: "songs"),
                    URLQueryItem(name: "offset", value: "\(offset)")
                ]
                return queryItems
        }
    }
}
