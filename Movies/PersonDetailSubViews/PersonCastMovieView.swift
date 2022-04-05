//
//  PersonMediaView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/25/22.
//

import SwiftUI

struct PersonCastMovieView: View {
    @State private var showGridView = false
    let movies: [(commonData: CastForPerson.CommonData, movieData: PersonMovieData)]
    let columns = [GridItem(.adaptive(minimum: 110, maximum: 130))]
    
    var body: some View {
        Group {
            if showGridView {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: .sectionHeaders) {
                        Section(header: GridViewToggle(showGridView: $showGridView)){
                            ForEach(movies, id: \.commonData.id) { movie in
                                NavigationLink(destination:
                                                MovieDetailView(
                                                    movieID: String( movie.commonData.tmdbID ),
                                                    movieTitle: movie.movieData.title,
                                                    imagePath: movie.commonData.poster
                                                )
                                ) {
                                    PosterView(
                                        imagePath: movie.commonData.poster,
                                        title: movie.movieData.title,
                                        rating: movie.commonData.rating
                                    )
                                }
                            }
                        }
                    }
                }
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 5, pinnedViews: .sectionHeaders) {
                        Section(header: GridViewToggle(showGridView: $showGridView)) {
                            ForEach(movies, id: \.commonData.id) { movie in
                                NavigationLink(destination:
                                                MovieDetailView(
                                                    movieID: String( movie.commonData.tmdbID ),
                                                    movieTitle: movie.movieData.title,
                                                    imagePath: movie.commonData.poster
                                                )
                                ) {
                                    PersonMediaRowView(
                                        poster: movie.commonData.poster,
                                        mediaType: .castMovies,
                                        titleOrName: movie.movieData.title,
                                        date: movie.movieData.releaseDate,
                                        charcterOrJob: movie.commonData.character,
                                        rating: movie.commonData.rating,
                                        genres: movie.commonData.genres
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }/// end of group
        .padding(.horizontal)
    }
}


