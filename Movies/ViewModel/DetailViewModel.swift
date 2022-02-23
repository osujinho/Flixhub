//
//  DetailViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import Foundation

@MainActor class DetailViewModel: ObservableObject {
    @Published private(set) var errorMessage: String = ""
    @Published var isExpanded: Bool = false
    @Published private(set) var omdbDetail = OMDBDetail(rated: "", rating: "")
    @Published private(set) var tmdbDetail = TMDBDetail(backdrop: "", poster: "", releaseDate: "", tmdbID: 0, title: "", genre: [Genre](), plot: "", runtime: 0, imdbID: "")
    @Published private(set) var credits = CastDetail(cast: [Cast](), crew: [Crew]())
    @Published var hasError: Bool = false
    
    private let networkManager: NetworkManager
    let urlManager: URLManager
    
    init(networkManager: NetworkManager, urlManager: URLManager) {
        self.networkManager = networkManager
        self.urlManager = urlManager
    }
    
    // Get movie director information
    func getDirectors() -> [Crew] {
        credits.crew.filter { $0.job == "Director" }
    }
    
    // get movie detail
    func networkCall(id: String) async {
        self.hasError = false
        
        let url = urlManager.buildURL(movieType: .detail, id: id)
        
        do {
            // load JSON Object
            
            tmdbDetail = try await networkManager.makeCall(url: url)
            let creditsURL = urlManager.buildURL(movieType: .credits, id: String(tmdbDetail.tmdbID))
            let ombdURL = urlManager.buildURL(movieType: .omdb, value: tmdbDetail.imdbID)
            credits = try await networkManager.makeCall(url: creditsURL)
            omdbDetail = try await networkManager.makeCall(url: ombdURL)
            
        } catch {
            // Error in case data could not be loaded
            errorMessage = error.localizedDescription
            self.hasError = true
        }
    }
}
