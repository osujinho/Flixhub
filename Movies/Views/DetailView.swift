//
//  DetailView.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = DetailViewModel()
    
    let isUpcoming: Bool
    let movieID: String
    let movieTitle: String
    let imagePath: String?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
            
            if viewModel.isLoading {
                LoadingDetailView(movieTitle: movieTitle, imagePath: imagePath)
                    .transition(.scale)
            } else {
                VStack(spacing: 0) {
                    TrailerPlayer(
                        playTrailer: $viewModel.playTrailer,
                        videoID: viewModel.youtubeKey,
                        backdrop: viewModel.tmdbDetail.backdrop
                    )
                    .scaledToFit()
                    
                    VStack {
                        MovieTitleAndGenreView(
                            playTrailer: $viewModel.playTrailer,
                            movieDetail: viewModel.tmdbDetail,
                            ratingAndRated: viewModel.omdbDetail,
                            isUpcoming: isUpcoming
                        )
                        
                        SynopsisView(syposis: viewModel.tmdbDetail.plot)
                        
                        CastView(directors: viewModel.director, casts: viewModel.tmdbDetail.credits.cast)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    
                    Spacer()
                }
                .transition(.slide)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .task {
            await viewModel.getMovieDetail(id: movieID)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.white) /// Fix after implementing Both dark and light mode
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
