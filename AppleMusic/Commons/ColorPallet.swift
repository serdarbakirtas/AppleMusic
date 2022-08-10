//
//  ColorPallet.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 20.07.22.
//

import SwiftUI

/// The color referance: https://colorswall.com/palette/3936

enum ColorPallet {
    // PRIMARIES
    static let DARK_GRAY = Color("aplle_music_dark_gray")
    static let LIGHT_GRAY = Color("aplle_music_light_gray")
    static let WHITE = Color("aplle_music_white")
    static let BLUE = Color("aplle_music_blue")
    static let YELLOW = Color("aplle_music_yellow")
    static let LIGHT_PINK = Color("aplle_music_light_pink")
    static let RED = Color("aplle_music_red")
    static let GREEN = Color("aplle_music_green")
    
    // UI COLORS
    static let UI_DARK_GRAY = UIColor(named: "aplle_music_dark_gray")!
    static let UI_LIGHT_GRAY = UIColor(named: "aplle_music_light_gray")!
    static let UI_WHITE = UIColor(named: "aplle_music_white")!
    static let UI_BLUE = UIColor(named: "aplle_music_blue")!
    static let UI_YELLOW = UIColor(named: "aplle_music_yellow")!
    static let UI_LIGHT_PINK = UIColor(named: "aplle_music_light_pink")!
    static let UI_RED = UIColor(named: "aplle_music_red")!
    static let UI_GREEN = UIColor(named: "aplle_music_green")!
}

extension Color {
    
    static let appleDarkGray = ColorPallet.DARK_GRAY
    static let appleLightGray = ColorPallet.LIGHT_GRAY
    static let appleWhite = ColorPallet.WHITE
    static let appleBlue = ColorPallet.BLUE
    static let appleYellow = ColorPallet.YELLOW
    static let appleLightPink = ColorPallet.LIGHT_PINK
    static let appleRed = ColorPallet.RED
    static let appleGreen = ColorPallet.GREEN
    
    static let appleUIDarkGray = ColorPallet.UI_DARK_GRAY
    static let appleUILightGray = ColorPallet.LIGHT_GRAY
    static let appleUIWhite = ColorPallet.UI_WHITE
    static let appleUIBlue = ColorPallet.UI_BLUE
    static let appleUIYellow = ColorPallet.UI_YELLOW
    static let appleUILightPink = ColorPallet.UI_LIGHT_PINK
    static let appleUIRed = ColorPallet.UI_RED
    static let appleUIGreen = ColorPallet.UI_GREEN
}
