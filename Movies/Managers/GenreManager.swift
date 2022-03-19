//
//  GenreList.swift
//  Movies
//
//  Created by Michael Osuji on 3/18/22.
//

import Foundation

final class GenreManager {
    static let genreManager = GenreManager()
    
    private init() { }
    
    private let genres: [Int : String] = [
        28 : "Action",
        12 : "Adventure",
        16 : "Animation",
        35 : "Comedy",
        80 : "Crime",
        99 : "Documentary",
        18 : "Drama",
        10751 : "Family",
        14 : "Fantasy",
        36 : "History",
        27 : "Horror",
        10402 : "Music",
        9648 : "Mystery",
        10749 : "Romance",
        878 : "Science Fiction",
        10770 : "TV Movie",
        53 : "Thriller",
        10752 : "War",
        37 : "Western",
        10759 : "Action & Adventure",
        10762 : "Kids",
        10763 : "News",
        10764 : "Reality",
        10765 : "Sci-Fi & Fantasy",
        10766 : "Soap",
        10767 : "Talk",
        10768 : "War & Politics"
    ]
    
    func getGenre(genreID: [Int]?) -> [String] {
        var list: [String] = []
        guard let genreID = genreID else { return [] }

        for id in genreID {
            if genres.keys.contains(id) {
                if let genre = genres[id] {
                    list.append(genre)
                }
            }
        }
        return list
    }
}


