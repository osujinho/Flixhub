//
//  BrowseViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import Foundation

@MainActor class BrowseViewModel: ObservableObject {
    @Published private(set) var upcoming = MovieBrowseData(results: [], total_pages: 0)
    @Published private(set) var popular = MovieBrowseData(results: [], total_pages: 0)
    @Published private(set) var nowPlaying = MovieBrowseData(results: [], total_pages: 0)
    @Published private(set) var topRated = MovieBrowseData(results: [], total_pages: 0)
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    @Published private(set) var errorMessage: String = ""
    
    private let urlManager = URLManager.urlManager
    private let networkManager = NetworkManager.networkManager
    
    func fetchMovies() async {
        self.hasError = false
        self.isLoading = true
        
        let upcomingURL = urlManager.buildURL(movieType: .upcoming, value: "1")
        let nowPlayingURL = urlManager.buildURL(movieType: .nowPlaying, value: "1")
        let topRatedURL = urlManager.buildURL(movieType: .topRated, value: "1")
        let popularURL = urlManager.buildURL(movieType: .popular, value: "1")
        
        do {
            upcoming = try await networkManager.makeCall(url: upcomingURL)
            nowPlaying = try await networkManager.makeCall(url: nowPlayingURL)
            topRated = try await networkManager.makeCall(url: topRatedURL)
            popular = try await networkManager.makeCall(url: popularURL)
        } catch {
            // Error in case data could not be loaded
            errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
        self.isLoading = false
    }
}
