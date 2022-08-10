//
//  LoadingSpinnerOverlay.swift
//  AppleMusic
//
//  Created by Hasan Serdar Bakirtas on 10.08.22.
//

import Foundation
import SwiftUI

/// A loading spinner on top of a transparent overlay that is always visible.
struct LoadingSpinnerOverlay: View {

    var body: some View {
        ActivityIndicator(style: .medium, isAnimating: .constant(true))
            .accessibility(identifier: "loadingview")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.bottom)
    }
}

/// A loading indicator that is controlled by a RequestState (only visible in `.progressing` state).
struct RequestStateLoadingSpinnerOverlay<Value, Failure>: View {

    let requestState: RequestState<Value, Failure>

    var body: some View {
        if case .progressing = requestState {
            LoadingSpinnerOverlay()
        }
    }
}
