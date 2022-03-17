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
                
                EnumPickerView("Type", selection: $viewModel.searchMediaType)
                
                List {
                    if !viewModel.searchText.isEmpty {
                        switch viewModel.searchMediaType {
                        case .movie:
                            ForEach(viewModel.movies, id: \.0.id) { movie in
                                NavigationLink(destination:
                                                MovieDetailView(
                                                    isUpcoming: false,
                                                    movieID: String( movie.0.id ),
                                                    movieTitle: movie.1.title,
                                                    imagePath: movie.1.poster
                                                )
                                ) {
                                    ResultRowView(
                                        poster: movie.1.poster,
                                        mediaType: .movie,
                                        title: movie.1.title,
                                        date: movie.1.date)
                                }
                            }
                        case .show:
                            ForEach(viewModel.shows, id: \.0.id) { show in
                                NavigationLink(destination:
                                                ShowDetailView(
                                                    showId: String( show.0.id ),
                                                    showName: show.1.name,
                                                    imagePath: show.1.poster
                                                )
                                
                                ) {
                                    ResultRowView(
                                        poster: show.1.poster,
                                        mediaType: .show,
                                        title: show.1.name,
                                        date: show.1.date)
                                }
                            }
                        case .person:
                            ForEach(viewModel.people, id: \.0.id) { person in
                                NavigationLink(destination:
                                                PersonDetailView(
                                                    personID: String( person.0.id ),
                                                    name: person.1.name,
                                                    profile: person.1.profile
                                                )
                                ) {
                                    ResultRowView(
                                        poster: person.1.profile,
                                        mediaType: .person,
                                        title: person.1.name,
                                        knownFor: person.1.knownFor)
                                }
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
