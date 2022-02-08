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
        case poster = "Poser"
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

