//
//  PlayerControlsView.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 11.08.22.
//

import AVKit
import Foundation
import SwiftUI

struct PlayerControlsView: View {

    var musicURL: URL?

    @StateObject var player = AudioPlayer()

    var body: some View {
        HStack {
            
            buttonPlayPause
            
            sliderView
            
            buttonMute
        }
        .onAppear {
            if let url = musicURL {
                player.setCurrentItem(AVPlayerItem(url: url))
            }
        }
    }
}

extension PlayerControlsView {
    
    var buttonPlayPause: some View {
        Button(action: {
            player.playPause()
        }, label: {
            Image(systemName: player.iconPlayPause)
                .foregroundColor(.appleBlue)
        })
    }
    
    var buttonMute: some View {
        Button(action: {
            player.mute()
        }, label: {
            Image(systemName: player.iconMute)
                .foregroundColor(.appleBlue)
        })
    }

    var sliderView: some View {

        Slider(value: $player.currentTime, in: 0...(player.duration ?? 0), onEditingChanged: { isEditing in
            player.isEditingCurrentTime = isEditing
        })
        .accentColor(.appleBlue)
    }
}
