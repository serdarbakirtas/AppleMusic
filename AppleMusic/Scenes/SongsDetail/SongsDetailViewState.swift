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
    
    init(item: SongsItem) {
        self.item = item
    }
}
