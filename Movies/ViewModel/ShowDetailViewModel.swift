//
//  ShowDetailViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

@MainActor class ShowDetailViewModel: ObservableObject {
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var showDetail = ShowDetail(
        name: "",
        firstAirDate: nil,
        lastAirDate: nil,
        creators: [ShowCreator](),
        genres: [Genre](),
        backdrop: nil,
        poster: nil,
        episodes: nil,
        seasons: nil,
        synopsis: nil,
        status: nil,
        type: nil,
        videos: Video(results: [VideoResults]()),
        credits: Credit(cast: [Cast](), crew: [Crew]())
    )
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    @Published var playTrailer: Bool = false
    @Published var synopsisExpanded: Bool = false
    @Published var creditsOption: CreditsOption = .casts
    
    var youtubeKey: String {
        if let video = showDetail.videos.results.first(where: {
            $0.site.lowercased() == "youtube" && $0.type.lowercased() == "trailer"
        }) {
            return video.key
        }
        return ""
    }
    
    var mainCrew: [Crew] {
        let desiredCrew: Set = ["producer", "screenplay", "story", "director"]
        return showDetail.credits.crew.filter{ desiredCrew.contains( $0.job.lowercased() ) }
    }
    
    var gridCollections: [GridCollection] {
        [
            GridCollection(label: "Type", info: showDetail.type?.capitalized ?? "N/A"),
            GridCollection(label: "Status", info: showDetail.status?.capitalized ?? "N/A"),
            GridCollection(label: "From", info: getDate(date: showDetail.firstAirDate ,forYear: false)),
            GridCollection(label: "To", info: getDate(date: showDetail.lastAirDate ,forYear: false)),
            GridCollection(label: "Seasons", info: unwrapNumbersToString(showDetail.seasons)),
            GridCollection(label: "Episodes", info: unwrapNumbersToString(showDetail.episodes))
        ]
    }
    
    private let networkManager = NetworkManager.networkManager
    private let urlManager = URLManager.urlManager
    
    func getShowDetail(id: String) async {
        self.hasError = false
        self.isLoading = true
        
        let url = urlManager.buildURL(movieType: .showDetail, id: id)
        
        do {
            showDetail = try await networkManager.makeCall(url: url)
            
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
}
