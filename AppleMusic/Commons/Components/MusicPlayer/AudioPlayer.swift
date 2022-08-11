//
//  PlayerViewModel.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 11.08.22.
//

import AVKit
import Combine

class AudioPlayer: AVPlayer, ObservableObject {
    
    /// status of play/pause and mute
    @Published var isPlaying = false
    @Published var isMute = false
    
    /// player durations
    @Published var isEditingCurrentTime = false
    @Published var currentTime: Double = .zero
    @Published var duration: Double?

    /// Update the icon as play or pause
    @Published var iconPlayPause = "pause.fill"
    @Published var iconMute = "speaker.3.fill"

    private var subscriptions: Set<AnyCancellable> = []
    private var timeObserver: Any?

    deinit {
        if let timeObserver = timeObserver {
            removeTimeObserver(timeObserver)
        }
    }

    override init() {
            super.init()

        $isEditingCurrentTime
            .dropFirst()
            .filter({ $0 == false })
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.seek(to: CMTime(seconds: self.currentTime, preferredTimescale: 1))
                if self.rate != 0 {
                    self.play()
                }
            })
            .store(in: &subscriptions)

        publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                switch status {
                case .playing:
                    self?.isPlaying = true
                    self?.iconPlayPause = "pause.fill"
                case .paused:
                    self?.isPlaying = false
                    self?.iconPlayPause = "play.fill"
                case .waitingToPlayAtSpecifiedRate:
                    break
                @unknown default:
                    break
                }
            }
            .store(in: &subscriptions)

        timeObserver = addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) { [weak self] time in
            guard let self = self else { return }
            if self.isEditingCurrentTime == false {
                self.currentTime = time.seconds
            }
        }
    }

    func setCurrentItem(_ item: AVPlayerItem) {
        currentTime = .zero
        duration = nil
        replaceCurrentItem(with: item)
        
        item.publisher(for: \.status)
            .filter({ $0 == .readyToPlay })
            .sink(receiveValue: { [weak self] _ in
                self?.duration = item.asset.duration.seconds
                self?.play()
            })
            .store(in: &subscriptions)
    }

    func playPause() {
        isPlaying ? pause() : play()
    }

    func mute() {
        isMuted.toggle()
        if isMuted {
            iconMute = "speaker.fill"
        } else {
            iconMute = "speaker.3.fill"
        }
    }
}
