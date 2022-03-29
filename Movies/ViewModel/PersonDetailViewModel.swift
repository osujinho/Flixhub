//
//  CastMovieViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/8/22.
//

import Foundation

@MainActor class PersonDetailViewModel: ObservableObject {
    @Published private(set) var personDetail = PersonDetail(
        name: "",
        birthday: nil,
        deathday: nil,
        knownFor: nil,
        gender: nil,
        birthPlace: nil,
        profile: nil,
        biography: nil,
        credits: PersonCredit(
            cast: [CastForPerson](),
            crew: [CrewForPerson]()
        ),
        images: ProfileImages(profiles: [MovieImage]())
    )
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    @Published var personCreditsOption: PersonCreditsOption = .castMovies
    @Published var personDetailOption: PersonDetailOptions = .about
    @Published var biographyIsExpanded: Bool = false
    
    var castMovies: [CastMovie] {
        personDetail.credits.cast.compactMap { movie in
            guard case let .movie(commonData, movieData) = movie else { return nil }
            return CastMovie(commonData: commonData, movieData: movieData)
        }
    }
    
    var castShows: [CastShow] {
        personDetail.credits.cast.compactMap { show in
            guard case let .tv(commonData, showData) = show else { return nil }
            return CastShow(commonData: commonData, showData: showData)
        }
    }
    
    var crewMovies: [CrewMovie] {
        personDetail.credits.crew.compactMap { movie in
            guard case let .movie(commonData, movieData) = movie else { return nil }
            return CrewMovie(commonData: commonData, movieData: movieData)
        }
    }
    
    var crewShows: [CrewShow] {
        personDetail.credits.crew.compactMap { show in
            guard case let .tv(commonData, showData) = show else { return nil }
            return CrewShow(commonData: commonData, showData: showData)
        }
    }
    
    private let networkManager = NetworkManager.networkManager
    private let urlManager = URLManager.urlManager
    
    func getDetail(castId: String) async {
        self.hasError = false
        self.isLoading = true
        
        let urlString = urlManager.buildURL(movieType: .personDetail, id: castId)
        
        do {
            personDetail = try await networkManager.makeCall(url: urlString)
            self.isLoading = false
            
        } catch {
            self.errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
    }
}



