//
//  MainView.swift
//  Movies
//
//  Created by Michael Osuji on 3/10/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: BrowseViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: BrowseViewModel())
        
        // Fix tab color here
        UITabBar.appearance().backgroundColor = UIColor(named: "tabColor")
    }
    
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
