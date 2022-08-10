//
//  Songs.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

import Foundation

struct Songs: Decodable {

    let data: [SongData]
}

struct SongData: Decodable {

    let id: String
    let type: ChartTypes
    let attributes: SongAttributes
}

struct SongAttributes: Decodable {

    let previews: [Previews]
    let artwork: Artwork
    let artistName: String
    let url: URL?
    let discNumber: Int
    let genreNames: [String]
    let durationInMillis: Int
    let isAppleDigitalMaster: Bool
    let name: String
    let isrc: String
    let hasLyrics: Bool
    let albumName: String
    let playParams: PlayParams
    let trackNumber: Int
    let composerName: String?
    
    struct Artwork: Decodable {
        let width: Int
        let height: Int
        let bgColor: String
        let url: String?
    }

    struct Previews: Decodable {
        let url: URL?
    }
    
    struct PlayParams: Decodable {
        let id: String
        var kind: ChartTypes?
    }
}

enum ChartTypes: String, Decodable {
    case songs
    case albums
    case playlists
    case stations
    case musicVideos = "music-videos"
    case appleCurators = "apple-curators"
    case artists
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = ChartTypes(rawValue: label) ?? .songs
    }
}
