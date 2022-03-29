//
//  Fonts.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/27/22.
//

import SwiftUI

/// Font for the App
struct MovieFont: ViewModifier {
    let style: FontStyle
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(style.name, size: size))
    }
}

extension View {
    func movieFont(style: FontStyle, size: CGFloat) -> some View {
        self.modifier(MovieFont(style: style, size: size))
    }
}

enum FontStyle {
    case light, regular, bold
    
    var name: String {
        switch self {
        case .light: return "Arial Rounded MT Light"
        case .regular: return "Arial Rounded MT"
        case .bold: return "Arial Rounded MT Bold"
        }
    }
}

let navTitleSize: CGFloat = 35
let movieAndShowTitleSize: CGFloat = 22
let personNameSize: CGFloat = 20
let labelSize: CGFloat = 15
let bodySize: CGFloat = 12
let stackHeaderSize: CGFloat = 22
let posterRatingSize: CGFloat = 12
let posterTitleSize: CGFloat = 12
let detailPosterRatingSize: CGFloat = 12
let genreSize: CGFloat = 9
let browseLabelSize: CGFloat = 13
let pickerFontSize: CGFloat = 12
let inlineNavSize: CGFloat = 20
let petiteSize: CGFloat = 10
let listRowTitleSize: CGFloat = 18
let personDetailNameSize: CGFloat = 16
let personDetailHeaderSize: CGFloat = 13



