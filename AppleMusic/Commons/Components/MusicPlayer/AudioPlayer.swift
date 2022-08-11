//
//  AudioPlayer.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 11.08.22.
//

import AVKit
import Combine

class AudioPlayer: AVPlayer, ObservableObject {
    
    /// status of play/pause and mute
    @Published var isPlaying = false
    
    /// player durations
    @Published var isEditingCurrentTime = false
    @Published var currentTime: Double = .zero
    @Published var duration: Double?

    private var subscriptions: Set<AnyCancellable> = []
    private var timeObserver: Any?

    var timeToMinutesSeconds: String {
        let (m,s) = ((Int(currentTime) % 3600) / 60, (Int(currentTime) % 3600) % 60)
        let minutes =  m < 10 ? "0\(m)" : "\(m)"
        let seconds =  s < 10 ? "0\(s)" : "\(s)"
        return "\(minutes):\(seconds)"
    }

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
                case .paused:
                    self?.isPlaying = false
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
}


// MARK: - Child functions

extension AudioPlayer {

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
    }
}
