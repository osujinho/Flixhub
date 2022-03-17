//
//  ShowDetailModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/13/22.
//

import Foundation

struct ShowDetail: Hashable, Decodable {
    let name: String
    let firstAirDate: String?
    let lastAirDate: String?
    let creators: [ShowCreator]
    let genres: [Genre]
    let backdrop: String?
    let poster: String?
    let episodes: Int?
    let seasons: Int?
    let synopsis: String?
    let status: String?
    let type: String?
    let videos: Video
    let credits: Credit
    
    enum CodingKeys: String, CodingKey {
        case name, genres, status, videos, credits, type
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case creators = "created_by"
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case episodes = "number_of_episodes"
        case seasons = "number_of_seasons"
        case synopsis = "overview"
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
