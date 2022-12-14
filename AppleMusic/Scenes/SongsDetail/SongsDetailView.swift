//
//  SongsDetailView.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 20.07.22.
//

import AVKit
import Combine
import SwiftUI

struct SongsDetailView: View {

    @StateObject private var viewState: SongsDetailViewState
    @State private var interactor: SongsDetailInteractor

    init(interactor: SongsDetailInteractor) {
        _interactor = State(initialValue: interactor)
        _viewState = StateObject(wrappedValue: interactor.viewState)
    }

    var body: some View {
        ScrollView {
            GeometryReader { (geometry: GeometryProxy) in
                if let imageSong = viewState.item.songImage {
                        WebImageView(url: imageSong, widht: geometry.size.width, height: geometry.size.height)
                }
            }.frame(height: 400)

            VStack(alignment: .center, spacing: 8) {

                playerControlView
                
                artistView

                content
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
        .background(ColorPallet.WHITE)
    }
}


// MARK: - Child views

private extension SongsDetailView {

    var content: some View {
        
        HStack {
            VStack(alignment: .leading) {
                attiributesView
                
                genreItemsView
            }
            Spacer()
        }
    }

    var playerControlView: some View {

        VStack {
            if let musicURL = interactor.getMusicURL {
                PlayerControlsView(musicURL: musicURL)
            }
        }
    }
    
    var artistView: some View {
        CustomText(
            value: viewState.item.artistName,
            color: .appleDarkGray,
            fontSize: 16,
            weight: .bold,
            horizontalSize: false,
            verticalSize: true
        )
    }
    
    var attiributesView: some View {

        VStack(alignment: .leading) {
            CustomText(
                value: "Song: " + viewState.item.songName,
                color: .appleLightGray,
                fontSize: 14,
                horizontalSize: false,
                verticalSize: true
            )
            .padding(.top, 2)

            CustomText(
                value: "Album: " + viewState.item.albumName,
                color: .appleLightGray,
                fontSize: 14,
                horizontalSize: false,
                verticalSize: true
            )
        }
    }
    
    var genreItemsView: some View {

        VStack(alignment: .leading) {
            CustomText(
                value: "Genres",
                color: .appleDarkGray,
                fontSize: 16,
                weight: .bold,
                horizontalSize: true
            )
            
            Divider()
            
            ForEach(0 ..< viewState.item.genres.count, id: \.hashValue) { index in
                CustomText(
                    value: viewState.item.genres[index],
                    color: .appleLightGray,
                    fontSize: 14,
                    horizontalSize: false,
                    verticalSize: true
                )

                Divider()
            }
        }
        .padding(.top, 12)
    }
}

// MARK: - Preview Provider

#if DEBUG
struct SongsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongsDetailView(interactor: SongsDetailInteractor(item: SongsItem(item: songData)))
    }
}
#endif
