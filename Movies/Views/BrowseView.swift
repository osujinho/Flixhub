//
//  BrowseView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct BrowseView: View {
    @StateObject var viewModel = BrowseViewModel(networkManager: NetworkManager(), urlManager: URLManager())
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Upcoming
                CarouselView(categoryName: "Upcoming", categoryNameBackgroundColor: .orange, movies: viewModel.upcoming.results, isPoster: true, imageUrl: viewModel.urlManager.imageBaseUrl)
                
                // Now playing
                CarouselView(categoryName: "Now Playing", categoryNameBackgroundColor: .green, movies: viewModel.nowPlaying.results, isPoster: false, imageUrl: viewModel.urlManager.imageBaseUrl)
                
                // Popular
                CarouselView(categoryName: "Popular", categoryNameBackgroundColor: .blue, movies: viewModel.popular.results, isPoster: false, imageUrl: viewModel.urlManager.imageBaseUrl)
                
                // Top Rated
                CarouselView(categoryName: "Top Rated", categoryNameBackgroundColor: .yellow, movies: viewModel.topRated.results, isPoster: false, imageUrl: viewModel.urlManager.imageBaseUrl)
                
            }
            .navigationTitle("Browse")
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
        .navigationViewStyle(.stack)
    }
}
