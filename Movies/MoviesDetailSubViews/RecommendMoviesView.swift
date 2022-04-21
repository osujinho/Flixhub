//
//  RecommendMoviesView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import SwiftUI

struct RecommendMoviesView: View {
    @StateObject private var viewModel: RecommendMovieViewModel
    let totalPages: Int
    let results: [TMDBResult]
    let movieID: String
    
    init(totalPages: Int, results: [TMDBResult], movieID: String) {
        self._viewModel = StateObject(wrappedValue: RecommendMovieViewModel())
        self.totalPages = totalPages
        self.results = results
        self.movieID = movieID
    }
    
    var body: some View {
        Group {
            if viewModel.presentGridView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: .sectionHeaders) {
                    Section(header: GridViewToggle(showGridView: $viewModel.presentGridView)) {
                        ForEach(viewModel.movies, id: \.self) { movie in
                            NavigationLink(destination:
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
                            .task {
                                viewModel.currentMovie = movie
                                await viewModel.loadMoreMovieIfNeeded(currentMovie: movie)
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .simultaneousGesture(
                    DragGesture(
                        minimumDistance: viewModel.isLoading ? 0 : .infinity),
                    including: .all
                )
                .transition(.move(edge: .bottom))
                .padding(.horizontal, 10)
            } else {
                LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                    Section(header: GridViewToggle(showGridView: $viewModel.presentGridView)) {
                        ForEach(viewModel.movies, id: \.self) { movie in
                            NavigationLink(destination:
                                            MovieDetailView(
                                                movieID: String( movie.tmdbID ),
                                                movieTitle: movie.title,
                                                imagePath: movie.poster
                                            )
                            ) {
                                GetMoreRowView(movie: movie)
                            }
                            .task {
                                viewModel.currentMovie = movie
                                await viewModel.loadMoreMovieIfNeeded(currentMovie: movie)
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
        .padding(.bottom)
        .onAppear{
            viewModel.movies = results
            viewModel.totalPages = totalPages
            viewModel.movieID = movieID
        }
    }
}
