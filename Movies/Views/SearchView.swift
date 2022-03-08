//
//  SearchView.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel(networkManager: NetworkManager())
    
    var body: some View {
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
                VStack {
                    Text("Movies matching ".appending(viewModel.movieTitle))
                    
                    List {
                        ForEach(viewModel.searchResult.results, id: \.self) { movie in
                            NavigationLink( destination:
                                                DetailView(
                                                    isUpcoming: false,
                                                    movieID: String( movie.tmdbID ),
                                                    movieTitle: movie.title,
                                                    imagePath: movie.poster
                                                )
                            ) {
                                ResultRowView(movie: movie)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Search For Movie")
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
