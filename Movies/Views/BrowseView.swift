//
//  BrowseView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct BrowseView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                CarouselView(categoryName: "Now Playing", categoryNameBackgroundColor: .blue, movies: <#T##[TMDBResult]#>, isPoster: true)
                CarouselView(categoryName: "Upcoming", categoryNameBackgroundColor: .green, movies: <#T##[TMDBResult]#>, isPoster: false)
                
            }
            .navigationTitle("Browse")
        }
        .navigationViewStyle(.stack)
    }
}
