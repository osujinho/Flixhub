//
//  DetailViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import SwiftUI  /// Need for animation

@MainActor class MovieDetailViewModel: ObservableObject {
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var omdbDetail = OMDBDetail(rated: "", awards: nil, boxOffice: nil, dvd: nil, ratings: [])
    @Published private(set) var tmdbDetail = TMDBDetail(backdrop: nil, poster: nil, releaseDate: nil, tmdbID: 0, title: "", originalTitle: nil, originalLanguage: nil, genres: [], plot: nil, runtime: 0, imdbID: "", status: nil, rating: nil, budget: nil, revenue: nil, countries: [], companies: [], spokenLanguages: [], credits: Credit(cast: [], crew: []), videos: Video(results: []), images: MovieImages(backdrops: [], posters: []))
    @Published private(set) var recommendedMovies = RecommendAndSimilar(pages: 0, results: [])
    @Published private(set) var similarMovies = RecommendAndSimilar(pages: 0, results: [])
    @Published var hasError: Bool = false
    @Published private(set) var isLoading: Bool = true
    @Published var playTrailer: Bool = false
    @Published var mediaOptions: MediaDetailOptions = .about
    
    var youtubeKey: String {
        if let video = tmdbDetail.videos.results.first(where: {
            $0.site.lowercased() == "youtube" && $0.type.lowercased() == "trailer"
        }) {
            return video.key
        }
        return ""
    }
    
    var featuredCrews: [String : (id: Int, profile: String?, job: String)] {
        var crews: [String : (id: Int, profile: String?, job: String)] = [:]
        
        let desiredCrewJobs: Set = ["producer", "director", "story", "executive producer", "storyboard", "screenplay", "co-producer"]
        
        let desiredCrews = tmdbDetail.credits.crew.filter { desiredCrewJobs.contains($0.job.lowercased()) }
        
        for crew in desiredCrews {
            if crews[crew.name] != nil {
                if let value = crews[crew.name] {
                    let job = value.job.appending(", \(crew.job.capitalized)")
                    crews.updateValue((value.id, value.profile, job), forKey: crew.name)
                }
            } else {
                crews[crew.name] = (crew.id, crew.profile_path, crew.job)
            }
        }
        return crews
    }
    
    var spokenLanguages: String {
        var languages: [String] = []
        let container = tmdbDetail.spokenLanguages
        
        for language in container {
            if let name = language.name {
                languages.append(name)
            } else {
                languages.append(getLanguage(code: language.code))
            }
        }
        return languages.joined(separator: ", ")
    }
    
    private let networkManager = NetworkManager.networkManager
    private let urlManager = URLManager.urlManager
    
    // get movie detail
    func getMovieDetail(id: String) async {
        self.hasError = false
        self.isLoading = true
        
        let url = urlManager.buildURL(movieType: .movieDetail, id: id)
        let recommendURL = urlManager.buildURL(movieType: .recommendMovies, id: id, value: "1")
        let similarURL = urlManager.buildURL(movieType: .similarMovie, id: id, value: "1")
        
        do {
            /// load JSON Object
            
            tmdbDetail = try await networkManager.makeCall(url: url)
            let ombdURL = urlManager.buildURL(movieType: .omdb, value: tmdbDetail.imdbID)
            omdbDetail = try await networkManager.makeCall(url: ombdURL)
            recommendedMovies = try await networkManager.makeCall(url: recommendURL)
            similarMovies = try await networkManager.makeCall(url: similarURL)
            
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

//enum CriticsRating: Identifiable, CustomStringConvertible {
//    case imdb, rottenTomatoes, metacritic
//
//    var id: CriticsRating { self }
//
//    var description: String {
//        switch self {
//        case .imdb: return "Internet Movie Database"
//        case .rottenTomatoes: return "Rotten Tomatoes"
//        case .metacritic: return "Metacritic"
//        }
//    }
//}
