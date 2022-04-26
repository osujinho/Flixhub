//
//  ViewComposition.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

let screen = UIScreen.main.bounds
let columns = [GridItem(.adaptive(minimum: 110, maximum: 130))]
let posterLabelColor = (Color(red: 3 / 255.0, green: 37 / 255.0, blue: 65 / 255.0))

// Modifier for the labels
struct DetailLabelViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .movieFont(style: .bold, size: detailLabelFontSize)
            .frame(width: screen.width * 0.4, alignment: .leading)
            .multilineTextAlignment(.leading)
            .foregroundColor(.secondary)
    }
}

extension View {
    func detailLabelViewModifier() -> some View {
        self.modifier(DetailLabelViewModifier())
    }
}

// Modifier for the Info
struct DetailInfoViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .movieFont(style: .regular, size: bodySize)
            .frame(width: screen.width * 0.4, alignment: .leading)
            .multilineTextAlignment(.leading)
            .foregroundColor(.primary)
    }
}

extension View {
    func detailInfoViewModifier() -> some View {
        self.modifier(DetailInfoViewModifier())
    }
}
