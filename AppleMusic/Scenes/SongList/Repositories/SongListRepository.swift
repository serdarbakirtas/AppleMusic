//
//  SongListRepository.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 19.07.22.
//

import Foundation

public enum SongListRepository {
    case getFilteredSongList(term: String, offset: Int)
}

struct StandartSongListRepository: CodableAPIRequest {

    typealias Response = Search
    
    var apiRepo: SongListRepository
    
    init(apiRepo: SongListRepository) {
        self.apiRepo = apiRepo
    }

    /// set path url
    var path: String {
        switch apiRepo {
            case .getFilteredSongList:
                return "search"
        }
    }

    /// get method
    var method: HTTPMethod {
        switch apiRepo {
            case .getFilteredSongList:
                return .get
        }
    }

    /// set query items (parameters)
    var params: [URLQueryItem]? {
        switch apiRepo {
        case .getFilteredSongList(term: let term, offset: let offset):
                let queryItems = [
                    URLQueryItem(name: "limit", value: "20"),
                    URLQueryItem(name: "types", value: "songs"),
                    URLQueryItem(name: "term", value: term),
                    URLQueryItem(name: "offset", value: "\(offset)")
                ]
                return queryItems
        }
    }
}
