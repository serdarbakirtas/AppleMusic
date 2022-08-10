//
//  SongsDetailViewState.swift
//  AppleMusic
//
//  Created by Hasan Serdar Bakirtas on 10.08.22.
//

import AVKit
import Combine
import SwiftUI

final class SongsDetailViewState: ObservableObject {

    /// Identifiable item of song
    @Published var item: SongsItem

    @Published var player = AVQueuePlayer()
    @Published var playing = false

    /// Current time of song
    @Published var currentTime: Double = 0.0

    /// Total duration of song
    @Published var duration: TimeInterval = 0

    /// Update the icon as play or pause
    @Published var iconPlayPause = "pause.fill"
    @Published var iconMute = "speaker.3.fill"
    
    init(item: SongsItem) {
        self.item = item
    }
}
