//
//  BrowseViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import Foundation

@MainActor class BrowseViewModel: ObservableObject {
    @Published private(set) var upcoming = Upcoming(results: [TMDBResult]())
    @Published private(set) var popular = Popular(results: [TMDBResult]())
    @Published private(set) var nowPlaying = NowPlaying(results: [TMDBResult]())
    @Published private(set) var topRated = TopRated(results: [TMDBResult]())
    @Published var hasError: Bool = false
    @Published private(set) var errorMessage: String = ""
    
    private let networkManager: NetworkManager
    let urlManager: URLManager
    
    init(networkManager: NetworkManager, urlManager: URLManager) {
        self.networkManager = networkManager
        self.urlManager = urlManager
    }
    
    func networkCall(type: MovieType, value: String) async {
        self.hasError = false
        
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
            default: return
            }
            
        } catch {
            // Error in case data could not be loaded
            errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
    }
}
