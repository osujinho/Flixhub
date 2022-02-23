//
//  Movie.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation
// shows movie for the browse view
struct TMDBResult: Hashable, Codable {
    let backdrop: String?
    let poster: String?
    let releaseDate: String
    let tmdbID: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case tmdbID = "id"
        case title
    }
}

struct Upcoming: Hashable, Codable {
    let results: [TMDBResult]
}

struct NowPlaying: Hashable, Codable {
    let results: [TMDBResult]
}

struct TMDBSearch: Hashable, Codable {
    let results: [TMDBResult]
}

struct TopRated: Hashable, Codable {
    let results: [TMDBResult]
}

struct Popular: Hashable, Codable {
    let results: [TMDBResult]
}

// For movie detail once clicked on
struct TMDBDetail: Hashable, Codable {
    let backdrop: String?
    let poster: String?
    let releaseDate: String
    let tmdbID: Int
    let title: String
    let genre: [Genre]
    let plot: String
    let runtime: Int
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case tmdbID = "id"
        case plot = "overview"
        case imdbID = "imdb_id"
        case genre = "genres"
        case title
        case runtime
        
    }
}

struct Genre: Hashable, Codable {
    let id: Int
    let name: String
}

// For getting OMDB Api
struct OMDBDetail: Hashable, Codable {
    let rated: String
    let rating: String
    
    enum CodingKeys: String, CodingKey {
        case rated = "Rated"
        case rating = "imdbRating"
    }
}

// For getting the Actor's details
struct CastDetail: Hashable, Codable {
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Hashable, Codable {
    let castID: Int
    let name: String
    let picture: String?
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case castID = "id"
        case picture = "profile_path"
        case name
        case character
    }
}

struct BrowseActor: Hashable, Codable {
    let cast: [CastMovies]
}

struct CastMovies: Hashable, Codable {
    let poster: String?
    let movieId: Int
    let title: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case movieId = "id"
        case releaseDate = "release_date"
        case title
    }
}

// For director
struct Crew: Hashable, Codable {
    let id: Int
    let name: String
    let profile_path: String?
    let job: String
}

struct UrlItem {
    let key: String
    let value: String
}

struct BrowseDirector: Hashable, Codable {
    let crew: [CrewMovies]
}

struct CrewMovies: Hashable, Codable {
    let movieId: Int
    let title: String
    let poster: String?
    let job: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case movieId = "id"
        case releaseDate = "release_date"
        case job
        case title
    }
}

enum MovieType: CaseIterable {
    case upcoming, nowPlaying, topRated, popular, detail, omdb, credits, search, browseActor, browseDirector
}
