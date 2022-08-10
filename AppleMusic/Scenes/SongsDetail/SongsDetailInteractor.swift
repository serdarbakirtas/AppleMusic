//
//  SongsDetailView+Observed.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 20.07.22.
//

import AVKit
import Combine
import SwiftUI

class SongsDetailInteractor {

    let viewState: SongsDetailViewState

    private let item: SongsItem
    
    init(item: SongsItem) {
        self.item = item
        self.viewState = SongsDetailViewState(item: item)
    }
    
    func setPlayer() {
        guard let m4aURL = viewState.item.m4aUrl else { return }
        viewState.player = AVQueuePlayer(playerItem: AVPlayerItem(url: m4aURL))
        play()
        
        viewState.player.addPeriodicTimeObserver(
            forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1),
            queue: DispatchQueue.main
        ) { time in
            if self.viewState.player.currentItem?.status == .readyToPlay {
                let currentTime = CMTimeGetSeconds(self.viewState.player.currentTime())
                self.viewState.currentTime = currentTime
            }
        }
        
        let durationSeconds = CMTimeGetSeconds((viewState.player.currentItem?.asset.duration)!)
        viewState.duration = durationSeconds
    }
    
    func playPause() {
        viewState.playing ? pause() : play()
    }
    
    func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            pause()
        } else {
            let targetTime = CMTime(seconds: viewState.currentTime, preferredTimescale: 600)
            viewState.player.seek(to: targetTime) { _ in
                self.play()
            }
        }
    }
}


// MARK: - Private functions

extension SongsDetailInteractor {

    private func pause() {
        viewState.player.pause()
        viewState.iconPlayPause = "play.fill"
        viewState.playing = false
    }

    private func play() {
        viewState.player.play()
        viewState.iconPlayPause = "pause.fill"
        viewState.playing = true
    }
    
    func mute() {
        viewState.player.isMuted.toggle()
        if viewState.player.isMuted {
            viewState.iconMute = "speaker.fill"
        } else {
            viewState.iconMute = "speaker.3.fill"
        }
    }
}
