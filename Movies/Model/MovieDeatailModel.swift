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
    let originalTitle: String?
    let originalLanguage: String?
    let genres: [Genre]
    let plot: String?
    let runtime: Int?
    let imdbID: String
    let status: String?
    let rating: Double?
    let budget: Int?
    let revenue: Int?
    let countries: [Name]
    let companies: [Name]
    let spokenLanguages: [SpokenLanguage]
    let credits: Credit
    let videos: Video
    let images: MovieImages
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case tmdbID = "id"
        case plot = "overview"
        case rating = "vote_average"
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case countries = "production_countries"
        case companies = "production_companies"
        case originalLanguage = "original_language"
        case spokenLanguages = "spoken_languages"
        case genres, title, runtime, credits, videos, images, status, budget, revenue
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
    let name: String?
}

/// For getting OMDB Api
struct OMDBDetail: Hashable, Decodable {
    let rated: String?
    let awards: String?
    let boxOffice: String?
    let dvd: String?
    let ratings: [Ratings]?
    
    enum CodingKeys: String, CodingKey {
        case rated = "Rated"
        case awards = "Awards"
        case boxOffice = "BoxOffice"
        case dvd = "DVD"
        case ratings = "Ratings"
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

struct Name: Hashable, Decodable {
    let name: String?
}

struct Ratings: Hashable, Decodable {
    let source: String
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

struct SpokenLanguage: Hashable, Decodable {
    let name: String?
    let code: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "english_name"
        case code = "iso_639_1"
    }
}

struct MovieReleaseDates: Hashable, Decodable {
    let results: [ReleaseResult]
}

struct ReleaseResult: Hashable, Decodable {
    let from: String?
    let releaseDate: [ReleaseDetail]
    
    private enum CodingKeys: String, CodingKey {
        case from = "iso_3166_1"
        case releaseDate = "release_dates"
    }
}

struct ReleaseDetail: Hashable, Decodable {
    let certification: String?
}
