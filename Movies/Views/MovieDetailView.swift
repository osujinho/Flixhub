//
//  DetailView.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: MovieDetailViewModel
    
    let movieID: String
    let movieTitle: String
    let imagePath: String?
    
    init(movieID: String, movieTitle: String, imagePath: String?) {
        self._viewModel = StateObject(wrappedValue: MovieDetailViewModel())
        self.movieID = movieID
        self.movieTitle = movieTitle
        self.imagePath = imagePath
    }
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            Group {
                if viewModel.isLoading {
                    LoadingView(
                        heading: "Loading details on \(movieTitle)",
                        poster: imagePath
                    )
                    .transition(.scale)
                } else {
                    GeometryReader{ proxy in
                        ScrollView {
                            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                                // top View
                                MovieDetailTopView(
                                    playTrailer: $viewModel.playTrailer,
                                    videoID: viewModel.youtubeKey,
                                    movieDetail: viewModel.tmdbDetail,
                                    rated: viewModel.omdbDetail.rated
                                )
                                .padding(.top, -proxy.safeAreaInsets.top)
                                
                                // header
                                Section(header:
                                            CustomPickerView(selection: $viewModel.mediaOptions, backgroundColor: "pickerColor")
                                    .padding(.bottom)
                                ) {
                                    switch viewModel.mediaOptions {
                                    case .about:
                                        MovieAboutView(
                                            tmdbDetail: viewModel.tmdbDetail,
                                            ombdDetail: viewModel.omdbDetail,
                                            spokenLanguages: viewModel.spokenLanguages)
                                    case .casts:
                                        CastView(casts: viewModel.tmdbDetail.credits.cast)
                                    case .crew:
                                        FeaturedCrewView(crews: viewModel.featuredCrews)
                                    case .media:
                                        MediaScrollView(
                                            posters: viewModel.tmdbDetail.images.posters.map{ $0.path },
                                            videos: viewModel.tmdbDetail.videos.results,
                                            backdrops: viewModel.tmdbDetail.images.backdrops.map{ $0.path })
                                    case .recommended:
                                        RecommendAndSimilarView(
                                            viewModel: GetMoreViewModel(),
                                            movieType: .recommendMovies,
                                            totalPages: viewModel.recommendedMovies.pages,
                                            results: viewModel.recommendedMovies.results
                                        )
                                    case .similar:
                                        RecommendAndSimilarView(
                                            viewModel: GetMoreViewModel(),
                                            movieType: .similarMovie,
                                            totalPages: viewModel.similarMovies.pages,
                                            results: viewModel.similarMovies.results
                                        )
                                    }
                                }
                                .frame(alignment: .leading)
                            }
                        }
                    }
                    .transition(.slide)
                }
            }
        }
        .background(Color("background"))
        .task {
            await viewModel.getMovieDetail(id: movieID)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .renderingMode(.original)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black) /// Fix after implementing Both dark and light mode
                })
            }
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Movie Detail Error"),
                message: Text(viewModel.errorMessage),
                primaryButton: .destructive(Text("Retry")) {
                    Task { await viewModel.getMovieDetail(id: movieID) }
                },
                secondaryButton: .cancel() {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
