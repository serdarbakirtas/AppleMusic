//
//  WebImageView.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 20.07.22.
//

import Foundation
import SwiftUI

struct WebImageView: View {
    var url: URL
    var widht: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        
        AsyncImage(url: url, transaction: .init(animation: .spring())) { phase in
            switch phase {
                case .empty:
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                    .opacity(0.2)
                    .transition(.opacity.combined(with: .scale))
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .transition(.opacity.combined(with: .scale))
            case .failure(_):
                ActivityIndicator(isAnimating: .constant(true), style: .medium)
            @unknown default:
                fatalError()
            }
        }
        .frame(width: widht, height: height)
        .mask(RoundedRectangle(cornerRadius: 8))
    }
}
