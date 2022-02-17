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

//// Modifier for the Poster and backdrop in the carousel of browse view
//struct CarouselImageViewModifier: ViewModifier {
//    let imagePath: String
//    let titleOrDate: String
//    let isPoster: Bool
//
//    let gradient = LinearGradient(
//        gradient: Gradient(stops: [
//            .init(color: .black, location: 0),
//            .init(color: .clear, location: 0.4)
//        ]),
//        startPoint: .bottom,
//        endPoint: .top
//    )
//
//    func body(content: Content) -> some View {
//        return content
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: isPoster ? 150 : 230)
//            .overlay(
//                ZStack(alignment: .bottom) {
//                    Image(imagePath)
//                        .resizable()
//                        .frame(width: isPoster ? 150 : 230)
//                        .blur(radius: 20) /// blur the image
//                        .padding(-20) /// expand the blur a bit to cover the edges
//                        .clipped() /// prevent blur overflow
//                        .mask(gradient) /// mask the blurred image using the gradient's alpha values
//
//                    gradient /// also add the gradient as an overlay (this time, the purple will show up)
//
//                    HStack {
//                        Spacer()
//                        VStack(alignment: .leading) {
//                            Text(isPoster ? getDate(date: titleOrDate, forYear: false) : titleOrDate)
//                                .font(.system(size: isPoster ? 12 : 18, weight: .bold))
//                                .opacity(isPoster ? 0.75 : 1)
//                                .padding(.bottom, 1)
//                        }
//                        Spacer()
//                    }
//                    .foregroundColor(.white)
//                    .padding(.bottom, 2)
//                }
//            )
//    }
//}
