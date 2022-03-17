//
//  DetailView.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = MovieDetailViewModel()
    
    let isUpcoming: Bool
    let movieID: String
    let movieTitle: String
    let imagePath: String?
    
    init(isUpcoming: Bool = false, movieID: String, movieTitle: String, imagePath: String?) {
        self.isUpcoming = isUpcoming
        self.movieID = movieID
        self.movieTitle = movieTitle
        self.imagePath = imagePath
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
            
            Group {
                if viewModel.isLoading {
                    LoadingView(
                        heading: "Loading details on \(movieTitle)",
                        poster: imagePath
                    )
                    .transition(.scale)
                } else {
                    VStack(spacing: 0) {
                        TrailerPlayer(
                            playTrailer: $viewModel.playTrailer,
                            synopsisExpanded: $viewModel.synopsisExpanded,
                            videoID: viewModel.youtubeKey,
                            backdrop: viewModel.tmdbDetail.backdrop
                        )
                        .scaledToFit()
                        .if(viewModel.playTrailer) { view in
                            view
                                .padding(.top, -50)
                                .padding(.bottom, 25)
                        }
                        
                        VStack {
                            
                            MovieTitleAndGenreView(
                                playTrailer: $viewModel.playTrailer,
                                synopsisExpanded: $viewModel.synopsisExpanded,
                                movieDetail: viewModel.tmdbDetail,
                                ratingAndRated: viewModel.omdbDetail,
                                isUpcoming: isUpcoming
                            )
                            
                            SynopsisOrBiographyView(
                                isExpanded: $viewModel.synopsisExpanded,
                                synopsis: viewModel.tmdbDetail.plot,
                                label: "Synopsis"
                            )
                            
                            CastListView(
                                synopsisExpanded: $viewModel.synopsisExpanded,
                                creditsOption: $viewModel.creditsOption,
                                directors: viewModel.director,
                                casts: viewModel.tmdbDetail.credits.cast
                            )
                        }
                        .frame(maxWidth: screen.width)
                        
                        Spacer()
                    }
                    .transition(.slide)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
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
