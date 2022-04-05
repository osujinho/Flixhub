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

enum MediaDetailOptions: Pickable {
    case about, casts, crew, media, recommended, similar

    var id: MediaDetailOptions { self }

    var description: String {
        switch self {
        case .about: return "About"
        case .casts: return "Casts"
        case .crew: return "Featured Crews"
        case .media: return "Media"
        case .recommended: return "Recommended"
        case .similar: return "Similar"
        }
    }
}

enum PersonDetailOptions: Pickable {
    case about, movies, shows, crewMovies, crewShows
    
    var id: PersonDetailOptions { self }
    
    var description: String {
        switch self {
        case .about: return "About"
        case .movies: return "Cast Movies"
        case .shows: return "Cast Shows"
        case .crewMovies: return "Crew Movies"
        case .crewShows: return "Crew Shows"
        }
    }
}

enum ShowDetailOption: Pickable {
    case about, seasons, casts, crew, media, recommended, similar

    var id: ShowDetailOption { self }

    var description: String {
        switch self {
        case .about: return "About"
        case .seasons: return "Seasons"
        case .casts: return "Casts"
        case .crew: return "Featured Crews"
        case .media: return "Media"
        case .recommended: return "Recommended"
        case .similar: return "Similar"
        }
    }
}
