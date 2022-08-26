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

    var musicURL: URL

    @StateObject var player = AudioPlayer()

    var body: some View {
        HStack {
            
            buttonPlayPause
            
            sliderView
            
            timerView
            
            buttonMute
        }
        .onAppear {
            player.setCurrentItem(AVPlayerItem(url: musicURL))
        }
    }
}

extension PlayerControlsView {

    var timerView: some View {
        CustomText(
            value: player.timeToMinutesSeconds,
            color: .appleDarkGray,
            fontSize: 16,
            horizontalSize: true,
            verticalSize: true
        )
    }

    var buttonPlayPause: some View {
        Button(action: {
            player.playPause()
        }, label: {
            Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .imageScale(.large)
                .foregroundColor(.appleBlue)
        })
    }
    
    var buttonMute: some View {
        Button(action: {
            player.mute()
        }, label: {
            Image(systemName: player.isMuted ? "pause.fill" : "speaker.3.fill")
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
