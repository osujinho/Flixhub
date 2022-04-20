//
//  ShowBrowseDetail.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import Foundation

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

struct ShowBrowseData: Hashable, Decodable {
    let results: [ShowResult]
    let total_pages: Int
}
