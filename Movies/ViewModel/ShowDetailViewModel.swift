//
//  ShowDetailViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

@MainActor class ShowDetailViewModel: ObservableObject {
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var showDetail = ShowDetail(id: 0, name: "", originalName: "", firstAirDate: nil, lastAirDate: nil, inProduction: nil, runtime: nil, creators: [], genres: [], backdrop: nil, lastEpisode: nil, nextEpisode: nil, poster: nil, totalEpisodes: nil, totalSeasons: nil, networks: [], companies: [], countries: [], spokenLanguages: [], synopsis: nil, status: nil, type: nil, originalLanguage: nil, seasons: [], videos: Video(results: []), credits: Credit(cast: [], crew: []), images: MovieImages(backdrops: [], posters: []), rating: nil)
    @Published private(set) var similarShows = ShowBrowseData(results: [], total_pages: 0)
    @Published private(set) var recommendShows = ShowBrowseData(results: [], total_pages: 0)
    @Published private(set) var showRatings = ShowRatings(results: [])
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    @Published var playTrailer: Bool = false
    @Published var trailerID: String = ""
    @Published private(set) var noTrailerAlertOpacity: CGFloat = 0
    @Published var showDetailOption: ShowDetailOption = .about
    
    /// Key maps to crew ID,
    /// MainCrew maps to crew
    ///  - name
    ///  - profile path for the profile image
    ///  - crew job
    var mainCrew: [Int : MainCrew] {
        var crews: [Int : MainCrew] = [:]
        let desiredCrew: Set = ["producer", "screenplay", "story", "director"]
        
        let selectedCrews =  showDetail.credits.crew.filter{ desiredCrew.contains( $0.job.lowercased() ) }
        
        for creator in showDetail.creators {
            crews.updateValue(MainCrew(name: creator.name, profile: creator.profile, job: "Creator"), forKey: creator.id)
        }
        
        for crew in selectedCrews {
            if let value = crews[crew.id] {
                let job = value.job.appending(", \(crew.job.capitalized)")
                crews.updateValue(MainCrew(name: crew.name, profile: crew.profile_path, job: job), forKey: crew.id)
                
            } else {
                crews[crew.id] = MainCrew(name: crew.name, profile: crew.profile_path, job: crew.job)
            }
        }
        return crews
    }
    
    var youtubeKey: String? {
        if let video = showDetail.videos.results.first(where: {
            $0.site.lowercased() == "youtube" && $0.type.lowercased() == "trailer"
        }) {
            return video.key
        }
        return nil
    }
    
    var videoClips: [VideoResults] {
        showDetail.videos.results.filter { $0.site.lowercased() == "youtube" }
    }
    
    var runtimes: String {
        guard let showRuntimes = showDetail.runtime else { return "N/A" }
        
        return showRuntimes.map { String($0).appending(" mins") }.joined(separator: ", ")
    }
    
    var spokenLanguages: String {
        var languages: [String] = []
        let container = showDetail.spokenLanguages
        
        for language in container {
            if let name = language.name {
                languages.append(name)
            } else {
                languages.append(getLanguage(code: language.code))
            }
        }
        return languages.joined(separator: ", ")
    }
    
    var inProduction: String {
        if let production = showDetail.inProduction {
            return production ? "Yes" : "No"
        }
        return "N/A"
    }
    
    var rated: String {
        let usRating = showRatings.results.filter{ $0.countryCode.lowercased() == "us" }
        
        if usRating.isEmpty {
            return "Unrated"
        }
        
        return usRating.compactMap{ $0.rating }.joined(separator: ", ")
    }
    
    private let networkManager = NetworkManager.networkManager
    private let urlManager = URLManager.urlManager
    
    func getShowDetail(id: String) async {
        self.hasError = false
        self.isLoading = true
        
        let url = urlManager.buildURL(movieType: .showDetail, id: id)
        let ratingURL = urlManager.buildURL(movieType: .showRatings, id: id)
        let recommendURL = urlManager.buildURL(movieType: .recommendShow, id: id, value: "1")
        let similarURL = urlManager.buildURL(movieType: .similarShow, id: id, value: "1")
        
        do {
            showDetail = try await networkManager.makeCall(url: url)
            similarShows = try await networkManager.makeCall(url: similarURL)
            showRatings = try await networkManager.makeCall(url: ratingURL)
            recommendShows = try await networkManager.makeCall(url: recommendURL)
            
            /// Slow the switching of screen
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    self.isLoading = false
                }
            }
        } catch {
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
