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
                    NavigationLink(destination:
                                    MovieGallery(
                                        images: movieDetail.images.posters, defaultImage: .poster)
                    ){
                        UrlImageView(path: movieDetail.poster, defaultImage: .poster)
                            .frame(width: detailPosterSize.width)
                            .cornerRadius(5)
                            .padding(.bottom, -2)
                        
                    }
                    
                }
                
                VStack(alignment: .leading) { /// For the Texts
                    HStack {
                        VStack {
                            Text(movieDetail.title.uppercased())   /// Title
                                .movieFont(style: .bold, size: movieAndShowTitleSize)
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
                            /// For rated
                            RatedAndRatingView(
                                label: "rated",
                                info: ratingAndRated.rated,
                                forRating: false
                            )
                            
                            Text(stringToTime(strTime: movieDetail.runtime))
                        } /// End of leading vstack
                        
                        Spacer()
                            .frame(maxWidth: 80)
                        
                        VStack(alignment: .leading, spacing: 10) { /// For trailing items
                           /// For rating
                            RatedAndRatingView(
                                label: "rating",
                                info: ratingAndRated.rating,
                                forRating: true
                            )
                            
                            Text( getDate(date: movieDetail.releaseDate, forYear: false) )
                            
                        }/// End of trailing vstack
                        
                        
                    } /// End of movie info HStack
                    .movieFont(style: .regular, size: bodySize)
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
