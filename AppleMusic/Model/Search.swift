//
//  Search.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

struct Search: Decodable {
    
    var results: SearchResults
}

struct SearchResults: Decodable {
    
    var songs: Songs
}
