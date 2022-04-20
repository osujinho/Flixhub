//
//  BrowseView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct BrowseView: View {
    @StateObject var viewModel: BrowseViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    // Now Playing
                    LazyVStack {
                        CarouselView(
                            categoryName: "Now Showing",
                            movieType: .nowPlaying,
                            movies: viewModel.nowPlaying.results,
                            totalPages: viewModel.nowPlaying.total_pages
                        )
                        
                        // Upcoming
                        CarouselView(
                            categoryName: "Upcoming",
                            movieType: .upcoming,
                            movies: viewModel.upcoming.results,
                            totalPages: viewModel.upcoming.total_pages
                        )
                        
                        // Popular
                        CarouselView(
                            categoryName: "Popular",
                            movieType: .popular,
                            movies: viewModel.popular.results,
                            totalPages: viewModel.popular.total_pages
                        )
                        
                        // Top Rated
                        CarouselView(
                            categoryName: "Top Rated",
                            movieType: .topRated,
                            movies: viewModel.topRated.results,
                            totalPages: viewModel.topRated.total_pages
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
