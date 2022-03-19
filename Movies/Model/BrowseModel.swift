//
//  BrowseMode.swift
//  Movies
//
//  Created by Michael Osuji on 3/13/22.
//

import Foundation

// shows movie for the browse view
struct TMDBResult: Hashable, Decodable {
    let tmdbRating: Double?
    let date: String?
    let poster: String?
    let tmdbID: Int
    let title: String
    let genreIds : [Int]?
    
    enum CodingKeys: String, CodingKey {
        case tmdbRating = "vote_average"
        case poster = "poster_path"
        case tmdbID = "id"
        case title
        case genreIds = "genre_ids"
        case date = "release_date"
    }
}

struct Upcoming: Hashable, Decodable {
    let results: [TMDBResult]
    let total_pages: Int
}

struct NowPlaying: Hashable, Decodable {
    let results: [TMDBResult]
    let total_pages: Int
}

struct TMDBSearch: Hashable, Decodable {
    let results: [TMDBResult]
    let total_pages: Int
}

struct TopRated: Hashable, Decodable {
    let results: [TMDBResult]
    let total_pages: Int
}

struct Popular: Hashable, Decodable {
    let results: [TMDBResult]
    let total_pages: Int
}
