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

let navTitleSize: CGFloat = 25
let movieAndShowTitleSize: CGFloat = 22
let labelSize: CGFloat = 15
let bodySize: CGFloat = 12
let browseLabelSize: CGFloat = 13
let inlineNavSize: CGFloat = 18
let petiteSize: CGFloat = 10
let listRowTitleSize: CGFloat = 18
let personDetailNameSize: CGFloat = 16
let personDetailHeaderSize: CGFloat = 13
let detailLabelFontSize: CGFloat = 14
