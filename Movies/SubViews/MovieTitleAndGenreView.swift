//
//  MovieTitleAndGenreView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI

struct MovieTitleAndGenreView: View {
    @Binding var playTrailer: Bool
    @Binding var synopsisExpanded: Bool
    let movieDetail: TMDBDetail
    let ratingAndRated: OMDBDetail
    let isUpcoming: Bool
    
    var body: some View {
        HStack {
            HStack(alignment: .bottom) { /// Container for alll
                if !playTrailer {
                    UrlImageView(path: movieDetail.poster, defaultImage: .poster)
                        .frame(width: detailPosterSize.width)
                        .padding(.bottom, -2)
                }
                
                VStack(alignment: .leading) { /// For the Texts
                    HStack {
                        VStack {
                            Text(movieDetail.title.uppercased())   /// Title
                                .movieFont(style: .title)
                                .padding(.bottom, 5)
                                .lineLimit(nil)
                        } /// Embed in a VStack so it can expand
                        
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
                    
                    HStack(alignment: .bottom) { /// To hold movie info
                        VStack(alignment: .leading, spacing: 10) { /// for leading items
                            HStack(alignment: .bottom, spacing: 10) { /// For rated
                                Text("Rated")
                                    .movieFont(style: .label)
                                Text(ratingAndRated.rated)
                                    .ratedAndRatingViewModifier(borderColor: .blue)
                            }
                            
                            Text(stringToTime(strTime: movieDetail.runtime))
                        } /// End of leading vstack
                        
                        Spacer()
                            .frame(maxWidth: 80)
                        
                        VStack(alignment: .leading, spacing: 10) { /// For trailing items
                            HStack(alignment: .bottom, spacing: 10) {
                                Text("Rating")
                                    .movieFont(style: .label)
                                Text(ratingAndRated.rating)
                                    .ratedAndRatingViewModifier(borderColor: .red)
                            }
                            
                            Text( getDate(date: movieDetail.releaseDate, forYear: false) )
                            
                        }/// End of trailing vstack
                        
                        
                    } /// End of movie info HStack
                    .movieFont(style: .body)
                    .padding(.bottom, 5)
//
                    HStack(alignment: .lastTextBaseline) { /// Stack for the genres
                        ForEach(movieDetail.genres, id: \.self) { genre in
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
