//
//  MovieDeatailModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/13/22.
//

import Foundation

// For movie detail once clicked on
struct TMDBDetail: Hashable, Decodable {
    let backdrop: String?
    let poster: String?
    let releaseDate: String?
    let tmdbID: Int
    let title: String
    let genres: [Genre]
    let plot: String?
    let runtime: Int?
    let imdbID: String
    let credits: Credit
    let videos: Video
    let images: MovieImages
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case tmdbID = "id"
        case plot = "overview"
        case imdbID = "imdb_id"
        case genres, title, runtime, credits, videos, images
    }
}

struct Genre: Hashable, Decodable {
    let name: String
}

/// To get the Actors details
struct Credit: Hashable, Decodable {
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Hashable, Decodable {
    let castID: Int
    let name: String
    let picture: String?
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case castID = "id"
        case picture = "profile_path"
        case name, character
    }
}

/// To Get directors details
struct Crew: Hashable, Decodable {
    let id: Int
    let name: String
    let profile_path: String?
    let job: String
}

/// To get Videos like trailer
struct Video: Hashable, Decodable {
    let results: [VideoResults]
}

struct VideoResults: Hashable, Decodable {
    let key: String
    let site: String
    let type: String
}

/// For getting OMDB Api
struct OMDBDetail: Hashable, Decodable {
    let rated: String
    let rating: String
    
    enum CodingKeys: String, CodingKey {
        case rated = "Rated"
        case rating = "imdbRating"
    }
}

struct MovieImages: Hashable, Decodable {
    let backdrops: [MovieImage]
    let posters: [MovieImage]
}

struct MovieImage: Hashable, Decodable {
    let rating: Double?
    let path: String?
    
    enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case path = "file_path"
    }
}
