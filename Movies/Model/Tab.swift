//
//  Tab.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import Foundation

enum Tab: Pickable {
    case movies, search
    
    var id: Tab { self }
    
    var description: String {
        switch self {
        case .movies: return "Movies"
        case .search: return "Search"
        }
    }
    
    var image: String {
        switch self {
        case .movies: return "list.and.film"
        case .search: return "magnifyingglass"
        }
    }
}
