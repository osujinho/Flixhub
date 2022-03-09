//
//  CastMovieView.swift
//  Movies
//
//  Created by Michael Osuji on 3/8/22.
//

import SwiftUI

struct FetchCastMovieView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CastMovieViewModel()
    
    let castName: String
    let forDirector: Bool
    let type: MovieType
    let castID: String
    let imagePath: String?
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView(
                    heading: forDirector ? "Getting more movies directed by \(castName)" : "Getting more movies with \(castName)",
                    imagePath: imagePath)
                    .transition(.slide)
            } else {
                VStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left.circle.fill")
                                .renderingMode(.original)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black) /// Fix after implementing Both dark and light mode
                        })
                            .padding(.leading, 10)

                        Spacer()
                    }
                    HStack(alignment: .lastTextBaseline) { /// Display heading including profile picture
                        UrlImageView(path: imagePath)
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)
                        
                        Text(castName.uppercased())
                            .movieFont(size: 22)
                        
                        Spacer()
                    }
                    .padding()
                    
                    List {
                        Section(header: Text("\(castName) movies").movieFont(size: 20).foregroundColor(.blue) ) {
                            if forDirector {
                                ForEach(viewModel.directorMovies.crew, id: \.self) { movie in
                                    NavigationLink(destination:
                                                    DetailView(
                                                        isUpcoming: false,
                                                        movieID: String( movie.movieId ),
                                                        movieTitle: movie.title,
                                                        imagePath: movie.poster
                                                    )
                                    ) {
                                        ResultRowView(
                                            poster: movie.poster,
                                            title: movie.title,
                                            releaseDate: movie.releaseDate
                                        )
                                    }
                                }
                            } else {
                                ForEach(viewModel.castMovies.cast, id: \.self) { movie in
                                    NavigationLink(destination:
                                                    DetailView(
                                                        isUpcoming: false,
                                                        movieID: String( movie.movieId ),
                                                        movieTitle: movie.title,
                                                        imagePath: movie.poster
                                                    )
                                    ) {
                                        ResultRowView(
                                            poster: movie.poster,
                                            title: movie.title,
                                            releaseDate: movie.releaseDate
                                        )
                                    }
                                }
                            }
                        }
                    } /// End of List
                    
                } /// End of VStack
            } /// End of Else block
        } /// End of parent VStack
        .task {
            await viewModel.fetchMovies(type: type, castId: castID)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Error Fetching Movies"),
                message: Text(viewModel.errorMessage),
                primaryButton: .destructive(Text("Retry")) {
                    Task {
                        await viewModel.fetchMovies(type: type, castId: castID)
                    }
                },
                secondaryButton: .cancel() { presentationMode.wrappedValue.dismiss() }
            )
        }
    }
}
