//
//  TrendingView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/29/22.
//

import SwiftUI

struct TrendingView: View {
    @State var viewModel: TrendingViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        // Trending Movies
                        CarouselView(
                            categoryName: "Trending Movies",
                            movieType: .trendingMovies,
                            movies: viewModel.trendingMovies.results,
                            totalPages: viewModel.trendingMovies.total_pages
                        )
                        
                        // Trending shows
                        ShowCarouselView(
                            categoryName: "Trending TV Shows",
                            showType: .trendingShows,
                            shows: viewModel.trendingShows.results,
                            totalPages: viewModel.trendingShows.total_pages
                        )
                        
                        // Popular
                        PeopleCarouselView(
                            categoryName: "Trending People",
                            type: .trendingPeople,
                            people: viewModel.trendingPeople.results,
                            totalPages: viewModel.trendingPeople.total_pages
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Trending")
                        .movieFont(style: .bold, size: navTitleSize)
                        .foregroundColor(.primary)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
