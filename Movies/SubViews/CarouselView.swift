//
//  CarouselView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct CarouselView: View {
     
    let categoryName: String
    let movieType: MovieType
    let movies: [TMDBResult]
    let totalPages: Int
     
    var body: some View {
        VStack {
            HStack {
                Text(categoryName)
                    .movieFont(style: .bold, size: browseLabelSize)
                Spacer()
                
                NavigationLink(destination:
                                GetMoreMovieView(
                                    header: categoryName,
                                    movieType: movieType,
                                    movies: movies,
                                    totalPages: totalPages
                                )
                ){
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10))
                }
                
            }.padding(.horizontal)
             
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .bottom, spacing: 5) {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink( destination:
                                            MovieDetailView(
                                                movieID: String( movie.tmdbID ),
                                                movieTitle: movie.title,
                                                imagePath: movie.poster
                                            )
                        ) {
                            PosterView(
                                imagePath: movie.poster,
                                title: movie.title,
                                rating: movie.tmdbRating
                            )
                        }
                    } //End ForEach
                    
                } //End HStack
                .padding(.leading, 10)
            }// End ScrollView
        }//End VStack
        .padding(.bottom)
    }
}

