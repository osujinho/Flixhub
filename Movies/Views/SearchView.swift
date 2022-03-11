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
                SearchBarView(searchText: $viewModel.searchText)
                    //.padding(.top, -30)
                
                List {
                    if !viewModel.searchText.isEmpty {
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
            }
            .navigationTitle("Search Movies")
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
                    secondaryButton: .cancel() { viewModel.searchText.removeAll() }
                )
            }
        }
        .navigationViewStyle(.stack)
    }
}
