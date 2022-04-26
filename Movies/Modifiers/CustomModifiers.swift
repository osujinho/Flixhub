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

// Modifier for the labels in detailViews
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

// Modifier for the Info in detailViews
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


// Modifier for the labels in list row views
struct RowLabelViewModifier: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .movieFont(style: .bold, size: detailLabelFontSize)
            .frame(width: width * 0.4, alignment: .leading)
            .multilineTextAlignment(.leading)
            .foregroundColor(.secondary)
    }
}

extension View {
    func rowLabelViewModifier(width: CGFloat) -> some View {
        self.modifier(RowLabelViewModifier(width: width))
    }
}


// Modifier for the Info in detailViews
struct RowInfoViewModifier: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .movieFont(style: .regular, size: bodySize)
            .frame(width: width * 0.4, alignment: .leading)
            .multilineTextAlignment(.leading)
            .foregroundColor(.primary)
    }
}

extension View {
    func rowInfoViewModifier(width: CGFloat) -> some View {
        self.modifier(RowInfoViewModifier(width: width))
    }
}
