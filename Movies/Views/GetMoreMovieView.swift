//
//  GetMoreView.swift
//  Movies
//
//  Created by Michael Osuji on 3/18/22.
//

import SwiftUI

struct GetMoreMovieView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: GetMoreViewModel
    
    let header: String
    let movieType: MovieType
    let movies: [TMDBResult]
    let totalPages: Int
    
    init(header: String, movieType: MovieType, movies: [TMDBResult], totalPages: Int) {
        self._viewModel = StateObject(wrappedValue: GetMoreViewModel())
        self.header = header
        self.movieType = movieType
        self.movies = movies
        self.totalPages = totalPages
    }
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            VStack {
                Group {
                    if viewModel.presentGridView {
                        ScrollView {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: .sectionHeaders) {
                                Section(header:
                                            GridViewToggle(showGridView: $viewModel.presentGridView)
                                    .padding(.bottom)
                                ) {
                                    ForEach(viewModel.movies, id: \.self){ movie in
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
                                    } /// End of ForEach
                                } /// End of section
                            } /// End of VGrid
                            
                        } /// End of scrollView
                        .simultaneousGesture(
                            DragGesture( minimumDistance: viewModel.isLoading ? 0 : .infinity ),
                            including: .all
                        )
                        .transition(.move(edge: .bottom))
                        .padding(.horizontal, 10)
                    } else {
                        
                        ScrollView {
                            LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                                Section(header:
                                            GridViewToggle(showGridView: $viewModel.presentGridView)
                                    .padding(.bottom)
                                ) {
                                    ForEach(viewModel.movies, id: \.self){ movie in
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
                                    } /// End of ForEach
                                    
                                } /// End of section
                            } /// End of lazyVStack
                        } /// End of scrollView
                        .transition(.move(edge: .bottom))
                        .padding(.horizontal, 10)
                    }
                } /// end of group
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            viewModel.movies = movies
            viewModel.totalPages = totalPages
            viewModel.movieType = movieType
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .renderingMode(.template)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary) /// Fix after implementing Both dark and light mode
                })
            }
            
            ToolbarItem(placement: .principal) {
                Text(header)
                    .movieFont(style: .bold, size: inlineNavSize)
            }
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Error Loading more movies"),
                message: Text(viewModel.errorMessage),
                dismissButton: .destructive(Text("Retry")) {
                    Task {
                        await viewModel.loadMoreMovieIfNeeded(currentMovie: viewModel.currentMovie)
                    }
                }
            )
        }
    }
}

