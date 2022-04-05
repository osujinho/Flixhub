//
//  ShowDetailModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/13/22.
//

import Foundation

struct ShowDetail: Hashable, Decodable {
    let id: Int
    let name: String
    let originalName: String
    let firstAirDate: String?
    let lastAirDate: String?
    let inProduction: Bool?
    let runtime: [Int]?
    let creators: [ShowCreator]
    let genres: [Genre]
    let backdrop: String?
    let lastEpisode: Episode?
    let nextEpisode: Episode?
    let poster: String?
    let totalEpisodes: Int?
    let totalSeasons: Int?
    let networks: [Name]
    let companies: [Name]
    let countries: [Name]
    let spokenLanguages: [SpokenLanguage]
    let synopsis: String?
    let status: String?
    let type: String?
    let originalLanguage: String?
    let seasons: [Season]
    let videos: Video
    let credits: Credit
    let images: MovieImages
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case name, genres, status, videos, credits, type, images, id, networks, seasons
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case creators = "created_by"
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case totalEpisodes = "number_of_episodes"
        case totalSeasons = "number_of_seasons"
        case synopsis = "overview"
        case runtime = "episode_run_time"
        case inProduction = "in_production"
        case lastEpisode = "last_episode_to_air"
        case nextEpisode = "next_episode_to_air"
        case originalName = "original_name"
        case originalLanguage = "original_language"
        case companies = "production_companies"
        case countries = "production_countries"
        case spokenLanguages = "spoken_languages"
        case rating = "vote_average"
    }
}

struct ShowCreator: Hashable, Decodable {
    let id: Int
    let name: String
    let profile: String?
    
    enum CodingKeys: String, CodingKey {
        case profile = "profile_path"
        case id, name
    }
}

struct Episode: Hashable, Decodable {
    let name: String?
    let airDate: String?
    let episodeNumber: Int
    let seasonNumber: Int
    let poster: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case poster = "still_path"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case seasonNumber = "season_number"
    }
}

struct Season: Hashable, Decodable {
    let id: Int
    let name: String?
    let airDate: String?
    let totalEpisodes: Int?
    let poster: String?
    let number: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case totalEpisodes = "episode_count"
        case poster = "poster_path"
        case number = "season_number"
    }
}

struct ShowRatings: Hashable, Decodable {
    let results: [ContentRating]
}

struct ContentRating: Hashable, Decodable {
    let countryCode: String
    let rating: String
    
    private enum CodingKeys: String, CodingKey {
        case countryCode = "iso_3166_1"
        case rating
    }
}

struct RecommendAndSimilarShow: Hashable, Decodable {
    let results: [ShowResult]
    let total_pages: Int
}

struct ShowResult: Hashable, Decodable {
    let id: Int
    let name: String
    let poster: String?
    let genres: [Int]?
    let date: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case poster = "poster_path"
        case genres = "genre_ids"
        case date = "first_air_date"
        case rating = "vote_average"
    }
}

