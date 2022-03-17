//
//  SearchViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 2/22/22.
//

import Foundation

@MainActor class SearchViewModel: ObservableObject {
    @Published private(set) var searchResult = Search(results: [SearchResult]())
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                Task { await searchMovie() }
            }
        }
    }
    @Published var searchSuccessful: Bool = false
    @Published var searchMediaType: SearchMediaType = .movie
    
    var movies: [(SearchResult.CommonData, SearchResult.MovieData)] {
        searchResult.results.compactMap { result in
            guard case let .movie(commonData, movieData) = result else { return nil }
            return (commonData, movieData)
        }
    }
    
    var shows: [(SearchResult.CommonData, SearchResult.ShowData)] {
        searchResult.results.compactMap { result in
            guard case let .tv(commonData, showData) = result else { return nil }
            return (commonData, showData)
        }
    }
    
    var people: [(SearchResult.CommonData, SearchResult.PersonData)] {
        searchResult.results.compactMap { result in
            guard case let .person(commonData, personData) = result else { return nil }
            return (commonData, personData)
        }
    }
    
    private let networkManager = NetworkManager.networkManager
    private let urlManager = URLManager.urlManager
    
    func searchMovie() async {
        self.hasError = false
        self.searchSuccessful = false
        
        let url = urlManager.buildURL(movieType: .search, value: searchText)
        
        do {
            // load JSON Object
            searchResult = try await networkManager.makeCall(url: url)
            searchSuccessful = true
        } catch {
            // Error in case data could not be loaded
            errorMessage = error.localizedDescription
            self.hasError = true
        }
    }
}


