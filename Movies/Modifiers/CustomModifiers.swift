//
//  ViewComposition.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

let screen = UIScreen.main.bounds

let personDetailProfilePictureSize: (width: CGFloat, height: CGFloat) = (screen.width * 0.25, screen.height * 0.15)
let listPosterSize: (width: CGFloat, height: CGFloat) = (screen.width * 0.26, screen.height * 0.18)
let detailPosterSize: (width: CGFloat, height: CGFloat) = (screen.width * 0.20, screen.height * 0.15)

let carouselPosterSize: (width: CGFloat, height: CGFloat) = (screen.width * 0.22, screen.height * 0.18)
let carouselBackdropSize: (width: CGFloat, height: CGFloat) = (screen.width * 0.4, screen.height * 0.15)
let trailerHeight: CGFloat = screen.height * 0.35
let biographyExpandedHeight: CGFloat = screen.height * 0.2

/// Font for the App
struct MovieFont: ViewModifier {
    let style: FontStyle
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(style.name, size: style.size))
    }
}

extension View {
    func movieFont(style: FontStyle) -> some View {
        self.modifier(MovieFont(style: style))
    }
}

enum FontStyle {
    case label, body, petite, name, title, appTitle, stackHeader
    
    var name: String {
        switch self {
        case .label, .name, .stackHeader: return "Sony Sketch EF Bold"
        case .body, .petite: return "Sony Sketch EF"
        case .title, .appTitle: return "Sony Sketch EF Bold"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .label: return 16
        case .body: return 14
        case .petite: return 12
        case .name: return 22
        case .title: return 27
        case .appTitle: return 37
        case .stackHeader: return 24
        }
    }
}

/// Circle text used in detail view for the rating
struct CircleTextViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.black)
            .padding(12)
            .background(Color.white)
            .clipShape(Circle())
            .padding(6)
            .background(Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 2)
            )
    }
}

extension View {
    func circleTextViewModifier() -> some View {
        self.modifier(CircleTextViewModifier())
    }
}

/// Squate Text used in detail view for the Rated text
struct SquareTextViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(.black)
            .padding(8)
            .background(Color.white)
            .clipShape(Rectangle())
            .padding(6)
            .background(Rectangle()
                .stroke(Color.white.opacity(0.7), lineWidth: 2)
            )
    }
}

extension View {
    func squareTextViewModifier() -> some View {
        self.modifier(SquareTextViewModifier())
    }
}

/// Genre text used in detail view
struct GenreTextViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .movieFont(style: .petite)
            .foregroundColor(.white.opacity(0.7))
            .padding(5)
            .background(Rectangle()
                .stroke(Color.white.opacity(0.7), lineWidth: 2)
            )
    }
}

extension View {
    func genreTextViewModifier() -> some View {
        self.modifier(GenreTextViewModifier())
    }
}


