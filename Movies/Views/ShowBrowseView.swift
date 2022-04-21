//
//  ShowBrowseView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/21/22.
//

import SwiftUI

struct ShowBrowseView: View {
    @StateObject var viewModel: ShowBrowseViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack {
                        
                        // Airing Today
                        ShowCarouselView(
                            categoryName: "Airing Today",
                            showType: .airingToday,
                            shows: viewModel.airingToday.results,
                            totalPages: viewModel.airingToday.total_pages
                        )
                        
                        // On The Air
                        ShowCarouselView(
                            categoryName: "On The Air",
                            showType: .onTheAir,
                            shows: viewModel.onTheAir.results,
                            totalPages: viewModel.onTheAir.total_pages
                        )
                        
                        // Popular
                        ShowCarouselView(
                            categoryName: "Popular Shows",
                            showType: .popularShows,
                            shows: viewModel.popularShows.results,
                            totalPages: viewModel.popularShows.total_pages
                        )
                        
                        // Top Rated
                        ShowCarouselView(
                            categoryName: "Top Rated Shows",
                            showType: .topRatedShows,
                            shows: viewModel.topRatedShows.results,
                            totalPages: viewModel.topRatedShows.total_pages
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("TV Shows")
                        .movieFont(style: .bold, size: navTitleSize)
                        .foregroundColor(.primary)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
