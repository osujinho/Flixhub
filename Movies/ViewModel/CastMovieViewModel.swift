//
//  CastMovieViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/8/22.
//

import Foundation

@MainActor class CastMovieViewModel: ObservableObject {
    @Published private(set) var castMovies = BrowseActor(cast: [CastMovies]())
    @Published private(set) var directorMovies = BrowseDirector(crew: [CrewMovies]())
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    
    private let networkManager = NetworkManager.networkManager
    private let urlManager = URLManager.urlManager
    
    func fetchMovies(type: MovieType, castId: String) async {
        self.hasError = false
        self.isLoading = true
        
        let urlString = urlManager.buildURL(movieType: type, id: castId)
        
        do {
            switch type {
            case .browseActor:
                castMovies = try await networkManager.makeCall(url: urlString)
                self.isLoading = false
            case .browseDirector:
                directorMovies = try await networkManager.makeCall(url: urlString)
                self.isLoading = false
            default: return
            }
            
        } catch {
            self.errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
    }
}
