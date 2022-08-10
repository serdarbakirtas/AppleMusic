//
//  Charts.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

struct Charts: Decodable {
    
    var results: Results
}

struct Results: Decodable {
    
    var songs: [Songs]
}
