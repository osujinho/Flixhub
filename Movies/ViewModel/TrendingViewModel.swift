//
//  TrendingViewModel.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/29/22.
//

import Foundation

@MainActor class TrendingViewModel: ObservableObject {
    @Published private(set) var trendingMovies = MovieBrowseData(results: [], total_pages: 0)
    @Published private(set) var trendingShows = ShowBrowseData(results: [], total_pages: 0)
    @Published private(set) var trendingPeople = PersonData(results: [], total_pages: 0)
    
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    @Published private(set) var errorMessage: String = ""
    
    private let urlManager = URLManager.urlManager
    private let networkManager = NetworkManager.networkManager
    
    func fetchTrending() async {
        self.hasError = false
        self.isLoading = true
        
        let moviesURL = urlManager.buildURL(movieType: .trendingMovies, value: "1")
        let showsURL = urlManager.buildURL(movieType: .trendingShows, value: "1")
        let peopleURL = urlManager.buildURL(movieType: .trendingPeople, value: "1")
        
        do {
            trendingMovies = try await networkManager.makeCall(url: moviesURL)
            trendingShows = try await networkManager.makeCall(url: showsURL)
            trendingPeople = try await networkManager.makeCall(url: peopleURL)
        } catch {
            // Error in case data could not be loaded
            errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
        self.isLoading = false
    }
}
