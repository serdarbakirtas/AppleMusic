//
//  SongsListViewState.swift
//  AppleMusic
//
//  Created by Hasan Serdar Bakirtas on 09.08.22.
//

import Combine
import SwiftUI

final class SongsListViewState: ObservableObject {

    // MARK: Published
    // Response data
    @Published var dataSource: [SongsItem] = []

    // When set to true, triggers to the next screen.
    @Published var goToNextScreen: Bool = false

    // Show error message if there is no response.
    @Published var errorMessage = APIError.responseError
    @Published var isShownError = false
    
    @Published var selectedIndex = 0
    
    // If count of data received is less than perPage value then it is last page.
    @Published var songListFull = false
    
    // Tracks last page loaded. Used to load next page (current + 1)
    @Published var currentPage = 0
}
