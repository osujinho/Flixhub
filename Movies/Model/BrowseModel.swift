//
//  BrowseMode.swift
//  Movies
//
//  Created by Michael Osuji on 3/13/22.
//

import Foundation

// shows movie for the browse view
struct TMDBResult: Hashable, Decodable {
    let backdrop: String?
    let poster: String?
    let releaseDate: String?
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

struct Upcoming: Hashable, Decodable {
    let results: [TMDBResult]
}

struct NowPlaying: Hashable, Decodable {
    let results: [TMDBResult]
}

struct TMDBSearch: Hashable, Decodable {
    let results: [TMDBResult]
}

struct TopRated: Hashable, Decodable {
    let results: [TMDBResult]
}

struct Popular: Hashable, Decodable {
    let results: [TMDBResult]
}
