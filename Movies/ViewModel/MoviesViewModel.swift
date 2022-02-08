//
//  MoviesViewBuilder.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation

@MainActor class MoviesViewModel: ObservableObject {
    @Published var title: String = ""
    @Published private(set) var state: State = .notAvailable
    @Published var hasError: Bool = false
    @Published var movieImdbID = ""
    
    private let networkManager: NetworkManager
    private let baseURL = "http://www.omdbapi.com/"
    private var queryItems = ["apiKey" : "4324aa3d"]
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // Add search item into query items dictionary
    private func buildSearchQuery() {
        queryItems.updateValue(title, forKey: "s")
        queryItems.removeValue(forKey: "i")
    }
    
    private func movieDetailQuery(imdbID: String) {
        queryItems.updateValue(imdbID, forKey: "i")
        queryItems.removeValue(forKey: "s")
    }
    
    // Function to seach for movies
    func searchMovie(forSearch: Bool, imdbID: String = "") async {
        self.state = .loadingSearchResult
        self.hasError = false
        
        forSearch ? buildSearchQuery() : movieDetailQuery(imdbID: imdbID)
        
        guard var url = URL(string: baseURL) else { return }
        url.buildURL(queries: queryItems)
        
        do {
            // load JSON Object
            if forSearch {
                let results: Search = try await networkManager.makeCall(url: url)
                self.state = .searchSuccessful(data: results)
            } else {
                let detail: Movie = try await networkManager.makeCall(url: url)
                self.state = .detailSuccessful(data: detail)
            }
        } catch {
            // Error in case data could not be loaded
            self.state = .failure(error: error)
            self.hasError = true
        }
    }
    
    // function to build an array from comma seperated string
    func buildArray(from sentence: String) -> [String] {
        sentence.components(separatedBy: ", ")
    }
}

enum State {
    case notAvailable
    case loadingSearchResult
    case loadingMovieDetail
    case searchSuccessful(data: Search)
    case detailSuccessful(data: Movie)
    case failure(error: Error)
}
