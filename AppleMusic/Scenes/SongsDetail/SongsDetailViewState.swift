//
//  SongsDetailViewState.swift
//  AppleMusic
//
//  Created by Hasan Serdar Bakirtas on 10.08.22.
//

import Combine
import SwiftUI

final class SongsDetailViewState: ObservableObject {
    
    @Published var item: SongsItem
    
    init(item: SongsItem) {
        self.item = item
    }
}

