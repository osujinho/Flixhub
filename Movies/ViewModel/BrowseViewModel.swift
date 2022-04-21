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
    
    func fetchMovies(type: MovieType, value: String) async {
        self.hasError = false
        self.isLoading = true
        
        let url = urlManager.buildURL(movieType: type, value: value)
        
        do {
            // load JSON Object
            switch type {
                
            case .upcoming:
                upcoming = try await networkManager.makeCall(url: url)
            case .nowPlaying:
                nowPlaying = try await networkManager.makeCall(url: url)
            case .topRated:
                topRated = try await networkManager.makeCall(url: url)
            case .popular:
                popular = try await networkManager.makeCall(url: url)
            default:
                self.isLoading = false
                return
            }
            
        } catch {
            // Error in case data could not be loaded
            errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
        self.isLoading = false
    }
}
