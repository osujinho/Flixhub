//
//  SearchView.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextFieldInput(target: $viewModel.movieTitle, label: "Movie Title", placeHolder: "Enter movie title to search...")
                    
                    Spacer()
                    
                    LabelButton(
                        label: "Search",
                        bgColor: .blue,
                        action: {
                            Task { await viewModel.searchMovie() }
                        },
                        isDisabled: viewModel.movieTitle.isEmpty)
                }
                .containerViewModifier(fontColor: .black, borderColor: .black)
                
                if viewModel.searchSuccessful {
                    List {
                        Section(header: Text("Movies matching \(viewModel.movieTitle)").movieFont(size: 20).foregroundColor(.blue) ) {
                            ForEach(viewModel.searchResult.results, id: \.self) { movie in
                                NavigationLink( destination:
                                                    DetailView( isUpcoming: false,
                                                                movieID: String( movie.tmdbID ),
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
                } else {
                    EmptyView()
                }
            }
            .navigationTitle("Search For Movie")
            .navigationBarHidden(viewModel.searchSuccessful ? true : false)
            .alert(isPresented: $viewModel.hasError) {
                Alert(
                    title: Text("Movie Search Error"),
                    message: Text(viewModel.errorMessage),
                    primaryButton: .destructive(Text("Retry")) {
                        Task {
                            await viewModel.searchMovie()
                        }
                    },
                    secondaryButton: .cancel() { viewModel.movieTitle.removeAll() }
                )
            }
        }
        .navigationViewStyle(.stack)
    }
}
