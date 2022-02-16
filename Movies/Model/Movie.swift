//
//  Movie.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation

struct Movie: Hashable, Codable {
    var title: String
    var rated: String
    var released: String
    var runtime: String
    var genre: String
    var director: String
    var actors: String
    var plot: String
    var poster: String
    var rating: String
    var imdbid: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case actors = "Actors"
        case director = "Director"
        case rating = "imdbRating"
        case rated = "Rated"
        case plot = "Plot"
        case poster = "Poster"
        case imdbid = "imdbID"
    }
}

struct Search: Codable {
    var results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case results = "Search"
    }
}

struct Result: Hashable, Codable {
    var title: String
    var year: String
    var imdbid: String
    var type: String
    var poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbid = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}

struct TMDBResult: Hashable, Codable {
    let backdrop: String
    let poster: String
    let releaseDate: String
    let tmdbID: Int
    let title: String
    let tmdbRating: Double
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case tmdbID = "id"
        case tmdbRating = "vote_average"
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

struct TMDBDetail: Hashable, Codable {
    let backdrop: String
    let poster: String
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

struct OMDBDetail: Hashable, Codable {
    let rated: String
    let year: String
    let rating: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case rated = "Rated"
        case year = "Year"
        case rating = "imdbRating"
        case imdbID
    }
}

struct CastDetail: Hashable, Codable {
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Hashable, Codable {
    let castID: Int
    let name: String
    let picture: String
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case castID = "id"
        case picture = "profile_path"
        case name
        case character
    }
}

struct Crew: Hashable, Codable {
    let id: Int
    let name: String
    let profile_path: String
    let job: String
}
