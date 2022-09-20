//
//  SongListItemView.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 19.07.22.
//

import SwiftUI

struct SongListItemView: View {
    
    private let songItem: SongsItem
    
    init(
        songItem: SongsItem
    ) {
        self.songItem = songItem
    }
    
    var body: some View {
        HStack {
            if let songImage = songItem.songImage {
                WebImageView(url: songImage, widht: 50, height: 50)
            }
            VStack(alignment: .leading) {
                CustomText(value: songItem.songName, color: .appleDarkGray, fontSize: 16, horizontalSize: false)
                CustomText(value: songItem.artistName, color: .appleLightGray, fontSize: 16, horizontalSize: false)
            }
        }
        .padding(.horizontal, 0).padding(.vertical, 4)
    }
}


// MARK: - Preview Provider

#if DEBUG
let playParams = SongAttributes.PlayParams(id: "", kind: .songs)
let artwork = SongAttributes.Artwork(width: 0, height: 0, bgColor: "", url: nil)
let preview = SongAttributes.Previews(url: nil)
let attiribute = SongAttributes(previews: [preview],
                                artwork: artwork,
                                artistName: "Tarkan",
                                url: nil,
                                discNumber: 0,
                                genreNames: [""],
                                durationInMillis: 0,
                                isAppleDigitalMaster: false,
                                name: "Kuzu Kuzu",
                                isrc: "",
                                hasLyrics: false,
                                albumName: "",
                                playParams: playParams,
                                trackNumber: 0,
                                composerName: "")
let songData = SongData(id: "0", type: .songs, attributes: attiribute)

struct SongListItemView_Previews: PreviewProvider {

    static var previews: some View {
        SongListItemView(
            songItem: SongsItem(item: songData))
    }
}
#endif
