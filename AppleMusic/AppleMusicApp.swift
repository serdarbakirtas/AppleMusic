//
//  AppleMusicApp.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

import SwiftUI

@main
struct AppleMusicApp: App {
    var body: some Scene {
        WindowGroup {
            SongsListView(interactor: SongsListInteractor())
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
