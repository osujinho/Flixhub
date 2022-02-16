//
//  ViewComposition.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

// Modifier for containers
struct ContainerViewModifier: ViewModifier {
    let fontColor: Color
    let borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(fontColor)
            .font(.system(size: 14))
            .padding(10)
            .background(Color.black.opacity(0.5).cornerRadius(10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke((borderColor), lineWidth: 2)
            )
            .padding(.horizontal, 15)
    }
}

extension View {
    func containerViewModifier(fontColor: Color, borderColor: Color) -> some View {
        self.modifier(ContainerViewModifier(fontColor: fontColor, borderColor: borderColor))
    }
}

// Circle text used in detail view
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

// Squate Text used in detail view
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

// Genre text used in detail view
struct GenreTextViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .semibold))
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

// Modifier for the Poster in detail view
struct PosterViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .clipped()
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(white: 0.4))
            )
            .shadow(radius: 3)
    }
}

extension View {
    func posterViewModifier() -> some View {
        self.modifier(PosterViewModifier())
    }
}
