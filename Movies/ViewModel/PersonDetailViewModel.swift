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
    @Published private var moreImages = MorePersonImage(results: [])
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    @Published var personCreditsOption: PersonCreditsOption = .castMovies
    @Published var personDetailOption: PersonDetailOptions = .about
    @Published var biographyIsExpanded: Bool = false
    
    var castMovies: [(commonData: CastForPerson.CommonData, movieData: PersonMovieData)] {
        personDetail.credits.cast.compactMap { movie in
            guard case let .movie(commonData, movieData) = movie else { return nil }
            return (commonData, movieData)
        }
    }
    
    var castShows: [(commonData: CastForPerson.CommonData, showData: PersonShowData)] {
        personDetail.credits.cast.compactMap { show in
            guard case let .tv(commonData, showData) = show else { return nil }
            return (commonData, showData)
        }
    }
    
    var crewMovies: [(commonData: CrewForPerson.CommonData, movieData: PersonMovieData)] {
        personDetail.credits.crew.compactMap { movie in
            guard case let .movie(commonData, movieData) = movie else { return nil }
            return(commonData, movieData)
        }
    }
    
    var crewShows: [(commonData: CrewForPerson.CommonData, showData: PersonShowData)] {
        personDetail.credits.crew.compactMap { show in
            guard case let .tv(commonData, showData) = show else { return nil }
            return(commonData, showData)
        }
    }
    
    var taggedImages: [String?] {
        var paths: [String?] = []
        let images = moreImages.results
            .map{ $0.media }
            .map{ $0.backdrop }
        
        for image in images {
            if !paths.contains(image) {
                paths.append(image)
            }
        }
        return paths
    }
    
    var backgroundImage: String? {
        self.taggedImages.isEmpty ? nil : taggedImages[0]
    }
    
    private let networkManager = NetworkManager.networkManager
    private let urlManager = URLManager.urlManager
    
    func getDetail(castId: String) async {
        self.hasError = false
        self.isLoading = true
        
        let urlString = urlManager.buildURL(movieType: .personDetail, id: castId)
        let imageURL = urlManager.buildURL(movieType: .taggedImages, id: castId, value: "1")
        
        do {
            personDetail = try await networkManager.makeCall(url: urlString)
            moreImages = try await networkManager.makeCall(url: imageURL)
            self.isLoading = false
            
        } catch {
            self.errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
    }
}



