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
    @Published var biographyIsExpanded: Bool = false
    
    var castMovies: [(CastForPerson.CommonData, PersonMovieData)] {
        personDetail.credits.cast.compactMap { movie in
            guard case let .movie(commonData, movieData) = movie else { return nil }
            return (commonData, movieData)
        }
    }
    
    var castShows: [(CastForPerson.CommonData, PersonShowData)] {
        personDetail.credits.cast.compactMap { show in
            guard case let .tv(commonData, showData) = show else { return nil }
            return (commonData, showData)
        }
    }
    
    var crewMovies: [(CrewForPerson.CommonData, PersonMovieData)] {
        personDetail.credits.crew.compactMap { movie in
            guard case let .movie(commonData, movieData) = movie else { return nil }
            return(commonData, movieData)
        }
    }
    
    var crewShows: [(CrewForPerson.CommonData, PersonShowData)] {
        personDetail.credits.crew.compactMap { show in
            guard case let .tv(commonData, showData) = show else { return nil }
            return(commonData, showData)
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



