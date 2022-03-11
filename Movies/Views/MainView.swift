//
//  MainView.swift
//  Movies
//
//  Created by Michael Osuji on 3/10/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = BrowseViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                SpashView()
            } else {
                TabView {
                    BrowseView(viewModel: viewModel)
                        .tabItem {
                            Label("Browse", systemImage: "list.dash")
                        }
                    SearchView()
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                }
                .background(Color.black)
            }
        }
        .task {
            await viewModel.fetchMovies(type: .upcoming, value: "1")
            await viewModel.fetchMovies(type: .nowPlaying, value: "1")
            await viewModel.fetchMovies(type: .topRated, value: "1")
            await viewModel.fetchMovies(type: .popular, value: "1")
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Error Loading Movies"),
                message: Text(viewModel.errorMessage),
                dismissButton: .destructive(Text("Retry")) {
                    // Use Task to run async method
                    Task {
                        await viewModel.fetchMovies(type: .upcoming, value: "1")
                        await viewModel.fetchMovies(type: .nowPlaying, value: "1")
                        await viewModel.fetchMovies(type: .topRated, value: "1")
                        await viewModel.fetchMovies(type: .popular, value: "1")
                    }
                }
            )
        }
    }
}
