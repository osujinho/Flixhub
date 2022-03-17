//
//  PickerEnums.swift
//  Movies
//
//  Created by Michael Osuji on 3/16/22.
//

import Foundation

enum CreditsOption: Pickable {
    case casts, crews
    
    var id: CreditsOption { self }
    
    var description: String {
        switch self {
        case .casts: return "Casts"
        case .crews: return "Crews"
        }
    }
}

enum PersonCreditsOption: Pickable {
    case castMovies, castShows, crewMovies, crewShows
    
    var id: PersonCreditsOption { self }
    
    var description: String {
        switch self {
        case .castMovies: return "Movies"
        case .castShows: return "TV Shows"
        case .crewMovies: return "Movie Crew"
        case .crewShows: return "Show Crew"
        }
    }
    
    var listLabel: String {
        switch self {
        case .castMovies, .crewMovies: return "Movies"
        case .castShows, .crewShows: return "TV Shows"
        }
    }
}

enum SearchMediaType: Pickable {
    case movie, show, person
    
    var id: SearchMediaType { self }

    var description: String {
        switch self {
        case .movie: return "Movies"
        case .show: return "TV Shows"
        case .person: return "People"
        }
    }
    
    var listRowLabel: String {
        switch self {
        case .movie: return "Movie"
        case .show: return "TV Show"
        case .person: return "Person"
        }
    }
}
