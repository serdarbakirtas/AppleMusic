//
//  AudioPlayerTests.swift
//  AppleMusicTests
//
//  Created by Hasan Bakirtas on 12.08.22.
//

import AVKit
import Combine
import XCTest
@testable import AppleMusic

class AudioPlayerTests: XCTestCase {

    var sut = AudioPlayer()

    var showThanksViewExpectation = XCTestCase().expectation(description: "Show Thanks View")

    
    override func setUp() {

        super.setUp()

        sut = AudioPlayer()
        sut.setCurrentItem(AVPlayerItem(url: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2a/3f/29/2a3f29fc-f013-ff53-a152-16a470ac53f8/mzaf_9924692073636280289.plus.aac.p.m4a")!))
    }

    func test_givenAudioPlayer_whenSetPlayerItem_thenPlaySound() {

        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.volume, 1)
        
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: 1)

        XCTAssertTrue(sut.isPlaying)
    }
    
    func test_givenAudioPlayer_whenSeekTime_thenCurrentTimeIsUpdated() {
       
        sut.seek(to: CMTime(seconds: 10, preferredTimescale: 1))
        
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: 1)

        XCTAssertEqual(sut.currentTime, 10)
        XCTAssertEqual(sut.timeToMinutesSeconds, "00:10")
    }
    
    func test_givenAudioPlayer_whenSetPause_thenIsPlayingFalse() {
       
        /// toggle is triggred
        sut.playPause()
        
        XCTAssertFalse(sut.isPlaying)
    }

    func test_givenAudioPlayer_whenSetUnmute_thenIsIsMutedFalse() {
       
        /// mute is triggred
        sut.mute()
        
        XCTAssertTrue(sut.isMuted)
    }
}

