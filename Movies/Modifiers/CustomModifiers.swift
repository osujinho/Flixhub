//
//  ViewComposition.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

let screen = UIScreen.main.bounds

let posterLabelColor = (Color(red: 3 / 255.0, green: 37 / 255.0, blue: 65 / 255.0))

let personDetailProfilePictureSize = (width: screen.width * 0.25, height: screen.height * 0.15)
let listPosterSize = (width: screen.width * 0.26, height: screen.height * 0.18)
let detailPosterSize = (width: screen.width * 0.20, height: screen.height * 0.15)

let carouselPosterSize = (width: CGFloat(110), height: CGFloat(200))
let carouselBackdropSize = (width: CGFloat(160), height: CGFloat(170))

let posterSize = (width: CGFloat(110), height: CGFloat(130))
let backdropSize = (width: CGFloat(160), height: CGFloat(100))

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

struct RatedAndRatingViewModifier: ViewModifier {
    let borderColor: Color
    func body(content: Content) -> some View {
        content
            .movieFont(style: .body)
            .foregroundColor(borderColor)
            .frame(width: 45, height: 18)
            .background(Rectangle()
                .stroke(borderColor.opacity(0.8), lineWidth: 2)
            )
    }
}

extension View {
    func ratedAndRatingViewModifier(borderColor: Color) -> some View {
        self.modifier(RatedAndRatingViewModifier(borderColor: borderColor))
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

struct DetailInfoGridView: View {
    let gridCollections: [GridCollection]
    
    let columns = [GridItem(.adaptive(minimum: 125, maximum: 190))]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 5) {
            ForEach(gridCollections, id: \.self) { item in
                HStack(alignment: .bottom, spacing: 10) {
                    Text(item.label)
                        .movieFont(style: .label)
                        .foregroundColor(.white)
                    Text(item.info)
                        .movieFont(style: .body)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
    }
}
