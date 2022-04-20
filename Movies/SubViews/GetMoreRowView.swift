//
//  GetMoreRowView.swift
//  Movies
//
//  Created by Michael Osuji on 3/18/22.
//

import SwiftUI

struct GetMoreRowView: View {
    let movie: TMDBResult
    let genreManager = GenreManager.genreManager
    let posterWidth: Double = 100
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            UrlImageView(path: movie.poster, defaultImage: .poster)
                .frame(width: CGFloat(posterWidth), height: CGFloat(posterWidth * 1.5))
                .cornerRadius(10)
                .overlay(
                    RatingView(rating: movie.tmdbRating, frameSize: 30)
                        .offset(x: 50, y: -50)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .multilineTextAlignment(.leading)
                    .movieFont(style: .bold, size: listRowTitleSize)
                
                Text(getDate(date: movie.date ,forYear: false))
                    .movieFont(style: .regular, size: labelSize)
                
                HStack(alignment: .bottom) {
                    Text(genreManager.getGenre(genreID: movie.genreIds).joined(separator: ", "))
                        .movieFont(style: .light, size: petiteSize)
                        .opacity(0.7)
                }
            }
            .foregroundColor(.primary)
        }
        .padding(.horizontal)
    }
}
