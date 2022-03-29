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

struct RatedAndRatingViewModifier: ViewModifier {
    let borderColor: Color
    func body(content: Content) -> some View {
        content
            .movieFont(style: .regular, size: genreSize)
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
            .movieFont(style: .light, size: genreSize)
            .foregroundColor(.secondary)
            .padding(5)
            .background(Rectangle()
                .stroke(.secondary, lineWidth: 2)
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
                        .movieFont(style: .bold, size: browseLabelSize)
                        .foregroundColor(.primary)
                    Text(item.info)
                        .movieFont(style: .regular, size: bodySize)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
