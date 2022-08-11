//
//  CustomText.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 20.07.22.
//

import SwiftUI

struct CustomText: View {
    
    var value: String
    var color: Color
    var fontSize: CGFloat
    var width: CGFloat?
    var weight: Font.Weight?
    var alignment: Alignment?
    var maxWidth: CGFloat?
    var horizontalSize: Bool?
    var verticalSize: Bool?
    
    var body: some View {
        VStack {
            Text(value)
                .frame(maxWidth: maxWidth ?? .infinity, alignment: alignment ?? .leading)
                .frame(width: width, alignment: alignment ?? .leading)
                .foregroundColor(color)
                .font(.system(size: fontSize, weight: weight ?? .regular, design: .default))
                .fixedSize(horizontal: horizontalSize ?? false, vertical: verticalSize ?? false)
        }
    }
}

#if DEBUG
struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(value: "Test", color: .appleDarkGray, fontSize: 20, weight: .bold, alignment: .center)
    }
}
#endif
