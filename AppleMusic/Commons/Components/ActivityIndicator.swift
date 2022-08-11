//
//  ActivityIndicator.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 20.07.22.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    let style: UIActivityIndicatorView.Style
    @Binding var isAnimating: Bool

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}


// MARK: - Preview

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityIndicator(style: .medium, isAnimating: .constant(true))
                .padding()
                .previewLayout(.sizeThatFits)

            ActivityIndicator(style: .large, isAnimating: .constant(true))
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
