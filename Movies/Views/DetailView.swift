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
                LoadingView(
                    heading: "Loading details on \(movieTitle)",
                    imagePath: imagePath
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
                    
                    VStack {
                        
                        MovieTitleAndGenreView(
                            playTrailer: $viewModel.playTrailer,
                            synopsisExpanded: $viewModel.synopsisExpanded,
                            movieDetail: viewModel.tmdbDetail,
                            ratingAndRated: viewModel.omdbDetail,
                            isUpcoming: isUpcoming
                        )
                        
                        SynopsisView(isExpanded: $viewModel.synopsisExpanded, syposis: viewModel.tmdbDetail.plot)
                        
                        CastListView(directors: viewModel.director, casts: viewModel.tmdbDetail.credits.cast)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    
                    Spacer()
                }
                .transition(.slide)
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
