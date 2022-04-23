//
//  DetailViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import SwiftUI  /// Need for animation

@MainActor class MovieDetailViewModel: ObservableObject {
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var omdbDetail = OMDBDetail(rated: nil, awards: nil, boxOffice: nil, dvd: nil, ratings: nil)
    @Published private(set) var tmdbDetail = TMDBDetail(backdrop: nil, poster: nil, releaseDate: nil, tmdbID: 0, title: "", originalTitle: nil, originalLanguage: nil, genres: [], plot: nil, runtime: nil, imdbID: nil, status: nil, rating: nil, budget: nil, revenue: nil, countries: [], companies: [], spokenLanguages: [], credits: Credit(cast: [], crew: []), videos: Video(results: []), images: MovieImages(backdrops: [], posters: []))
    @Published private(set) var recommendedMovies = MovieBrowseData(results: [], total_pages: 0)
    @Published private(set) var similarMovies = MovieBrowseData(results: [], total_pages: 0)
    @Published private var releaseDetail = MovieReleaseDates(results: [])
    @Published var hasError: Bool = false
    @Published private(set) var isLoading: Bool = true
    @Published var playTrailer: Bool = false
    @Published var trailerID: String = ""
    @Published private(set) var noTrailerAlertOpacity: CGFloat = 0
    @Published var mediaOptions: MediaDetailOptions = .about
    
    var youtubeKey: String? {
        if let video = tmdbDetail.videos.results.first(where: {
            $0.site.lowercased() == "youtube" && $0.type.lowercased() == "trailer"
        }) {
            return video.key
        }
        return nil
    }
    
    var videoClips: [VideoResults] {
        tmdbDetail.videos.results.filter { $0.site.lowercased() == "youtube" }
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
    
    var certifications: String {
        
        let allCertifications = releaseDetail.results.filter { $0.from?.lowercased() == "us" }.flatMap { $0.releaseDate }.compactMap { $0.certification }
        
        let uniqueCertifications = Set(allCertifications).filter { $0 != "" }
        
        if uniqueCertifications.isEmpty {
            return "Unrated"
        }
        
        return Array(uniqueCertifications).joined(separator: ", ")
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
        let releaseURL = urlManager.buildURL(movieType: .movieRelease, id: id)
        
        do {
            /// load JSON Object
            
            tmdbDetail = try await networkManager.makeCall(url: url)
            
            if let imdbID = tmdbDetail.imdbID {
                let ombdURL = urlManager.buildURL(movieType: .omdb, value: imdbID)
                omdbDetail = try await networkManager.makeCall(url: ombdURL)
            }
            releaseDetail = try await networkManager.makeCall(url: releaseURL)
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
    
    func checkForTrailer() {
        if let videoKey = youtubeKey {
            self.trailerID = videoKey
            self.playTrailer = true
        } else {
            noTrailerAlertOpacity = 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.noTrailerAlertOpacity = 0.0
            })
        }
    }
}
