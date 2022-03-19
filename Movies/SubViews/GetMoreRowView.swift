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
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            UrlImageView(path: movie.poster, defaultImage: .poster)
                .scaledToFill()
                .frame(width: 110, height: 170)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    RatingView(rating: movie.tmdbRating, frameSize: 35)
                        .padding(.top, 5)
                }
                Spacer()
                
                Text(movie.title.uppercased())
                    .movieFont(style: .name)
                
                Text(getDate(date: movie.date ,forYear: false))
                    .movieFont(style: .label)
                
                HStack(alignment: .bottom) {
                    Text(genreManager.getGenre(genreID: movie.genreIds).joined(separator: ", "))
                        .movieFont(style: .petite)
                        .opacity(0.7)
                }
            }
        }
    }
}
