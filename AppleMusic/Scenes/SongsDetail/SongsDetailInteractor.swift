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

    var getMusicURL: URL? {
        viewState.item.m4aUrl
    }

    init(item: SongsItem) {
        self.item = item
        self.viewState = SongsDetailViewState(item: item)
    }
}
