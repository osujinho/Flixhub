//
//  Tab.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import Foundation

enum Tab: Pickable {
    case trending, movies, shows, search
    
    var id: Tab { self }
    
    var description: String {
        switch self {
        case .trending: return "Trending"
        case .movies: return "Movies"
        case .shows: return "TV Shows"
        case .search: return "Search"
        }
    }
    
    var image: String {
        switch self {
        case .trending: return "chart.line.uptrend.xyaxis"
        case .movies: return "list.and.film"
        case .shows: return "tv.circle"
        case .search: return "magnifyingglass"
        }
    }
}
