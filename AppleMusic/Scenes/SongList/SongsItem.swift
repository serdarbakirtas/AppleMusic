//
//  SongsItem.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 19.07.22.
//

import SwiftUI

struct SongsItem: Identifiable {
    
    private let item: SongData

    var id: String {
        return item.id
    }

    var songName: String {
        return item.attributes.name
    }

    var albumName: String {
        return item.attributes.albumName
    }

    var artistName: String {
        return item.attributes.artistName
    }

    var genres: [String] {
        return item.attributes.genreNames
    }
    
    var m4aUrl: URL? {
        guard let url = item.attributes.previews.first?.url else { return nil }
        return url
    }

    var songImage: URL? {
        guard let url = item.attributes.artwork.url else { return URL(string: "") }
        return URL(string: url.replacingOccurrences(of: "{w}", with: "500").replacingOccurrences(of: "{h}", with: "500"))
    }

    init(item: SongData) {
        self.item = item
    }
}

extension SongsItem: Hashable {
    static func == (lhs: SongsItem, rhs: SongsItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
