//
//  SongsDetailView+Observed.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 20.07.22.
//

import Combine
import SwiftUI

class SongsDetailInteractor {

    let viewState: SongsDetailViewState

    private let item: SongsItem
    
    init(item: SongsItem) {
        self.item = item
        self.viewState = SongsDetailViewState(item: item)
    }
}
