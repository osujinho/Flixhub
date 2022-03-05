//
//  MovieTitleAndGenreView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI

struct MovieTitleAndGenreView: View {
    @Binding var playTrailer: Bool
    let movieDetail: TMDBDetail
    let ratingAndRated: OMDBDetail
    let isUpcoming: Bool
    
    var body: some View {
        HStack {
            HStack(alignment: .bottom) { /// Container for all
                AsyncImageView(path: movieDetail.poster)
                    .frame(width: 85, height: 110)
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading) { /// For the Texts
                    HStack {
                        Text(movieDetail.title.uppercased())   /// Title
                            .movieFont(size: 24)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        
                        Spacer()
                        
                        if playTrailer {
                            Button(action: {     // To Stop the trailer
                                withAnimation {
                                    playTrailer = false
                                }
                            }) {
                                Image(systemName: "stop.fill")
                            }
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.blue)
                        }
                    }
                    
                    HStack(alignment: .bottom) { /// For the runtime and year
                        Text(stringToTime(strTime: movieDetail.runtime))
                        Text(isUpcoming ?
                             getDate(date: movieDetail.releaseDate, forYear: false) :
                                getDate(date: movieDetail.releaseDate, forYear: true)
                        )
                    } /// End of  runtime and year stack
                    .movieFont(size: 14)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.bottom, 2)
                    
                    HStack(spacing: 12) { /// For the rating and Rated
                        Text(ratingAndRated.rated)
                            .foregroundColor(.blue)
                        Text(ratingAndRated.rating)
                            .foregroundColor(.red.opacity(0.8))
                    } /// End of rating and rated stack
                    .movieFont(size: 12)
                    .padding(.bottom, 5)
                    
                    HStack(alignment: .lastTextBaseline) { /// Stack for the genres
                        ForEach(movieDetail.genre, id: \.self) { genre in
                            Text(genre.name.capitalized)
                                .genreTextViewModifier()
                        }
                    } /// End of stack for Genres
                } /// End of Texts VStack
                
                Spacer()  /// To make items aligned leading in a HStack
        
            } /// End of container for all
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
        }
    }
}
