//
//  DetailViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import SwiftUI  /// Need for animation

@MainActor class MovieDetailViewModel: ObservableObject {
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var omdbDetail = OMDBDetail(rated: "", rating: "")
    @Published private(set) var tmdbDetail = TMDBDetail(
        backdrop: nil,
        poster: nil,
        releaseDate: "",
        tmdbID: 0,
        title: "",
        genres: [Genre](),
        plot: "",
        runtime: 0,
        imdbID: "",
        credits: Credit(cast: [Cast](), crew: [Crew]()),
        videos: Video(results: [VideoResults]()),
        images: MovieImages(backdrops: [MovieImage](), posters: [MovieImage]())
    )
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    @Published var playTrailer: Bool = false
    @Published var synopsisExpanded: Bool = false
    @Published var creditsOption: CreditsOption = .casts
    
    var youtubeKey: String {
        if let video = tmdbDetail.videos.results.first(where: {
            $0.site.lowercased() == "youtube" && $0.type.lowercased() == "trailer"
        }) {
            return video.key
        }
        return ""
    }
    
    var mainCrew: [Crew] {
        let desiredCrewJobs: Set = ["producer", "director", "story", "executive producer", "storyboard", "screenplay"]
        
        return tmdbDetail.credits.crew.filter { desiredCrewJobs.contains($0.job.lowercased()) }
    }
    
    private let networkManager = NetworkManager.networkManager
    private let urlManager = URLManager.urlManager
    
    // get movie detail
    func getMovieDetail(id: String) async {
        self.hasError = false
        self.isLoading = true
        
        let url = urlManager.buildURL(movieType: .movieDetail, id: id)
        
        do {
            /// load JSON Object
            
            tmdbDetail = try await networkManager.makeCall(url: url)
            let ombdURL = urlManager.buildURL(movieType: .omdb, value: tmdbDetail.imdbID)
            omdbDetail = try await networkManager.makeCall(url: ombdURL)
            
            /// Slow the switching of screen
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    self.isLoading = false
                }
            }
        } catch {
            // Error in case data could not be loaded
            errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
    }
}

