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
            VStack {
                ScrollView {
                    // Upcoming
                    CarouselView(categoryName: "Upcoming", categoryNameBackgroundColor: .orange, movies: viewModel.upcoming.results, isPoster: true)
                    
                    // Now playing
                    CarouselView(categoryName: "Now Playing", categoryNameBackgroundColor: .green, movies: viewModel.nowPlaying.results, isPoster: false)
                    
                    // Popular
                    CarouselView(categoryName: "Popular", categoryNameBackgroundColor: .blue, movies: viewModel.popular.results, isPoster: false)
                    
                    // Top Rated
                    CarouselView(categoryName: "Top Rated", categoryNameBackgroundColor: .yellow, movies: viewModel.topRated.results, isPoster: false)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(alignment: .lastTextBaseline, spacing: 10) {
                        Text("Flixhub")
                            .movieFont(style: .appTitle)
                            .foregroundColor(.blue.opacity(0.8))
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
