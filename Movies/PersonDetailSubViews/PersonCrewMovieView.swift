//
//  PersonCrewMovieView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/27/22.
//

import SwiftUI

struct PersonCrewMovieView: View {
    @State private var showGridView = false
    let columns = [GridItem(.adaptive(minimum: 110, maximum: 130))]
    let movies: [CrewMovie]
    
    var body: some View {
        if showGridView {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: .sectionHeaders) {
                    Section(header: GridViewToggle(showGridView: $showGridView)){
                        ForEach(movies, id: \.id) { movie in
                            NavigationLink(destination:
                                            MovieDetailView(
                                                movieID: String( movie.commonData.id ),
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
                        ForEach(movies, id: \.id) { movie in
                            NavigationLink(destination:
                                            MovieDetailView(
                                                movieID: String( movie.commonData.id ),
                                                movieTitle: movie.movieData.title,
                                                imagePath: movie.commonData.poster
                                            )
                            ) {
                                PersonMediaRowView(
                                    poster: movie.commonData.poster,
                                    mediaType: .crewMovies,
                                    titleOrName: movie.movieData.title,
                                    date: movie.movieData.releaseDate,
                                    charcterOrJob: movie.commonData.job,
                                    rating: movie.commonData.rating,
                                    genres: movie.commonData.genres
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}
