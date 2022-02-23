//
//  MovieType.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import Foundation

class URLManager {
    private let baseURL = "https://api.themoviedb.org/3/"
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    let omdpKey = UrlItem(key: "apikey", value: "4324aa3d")
    let tmdbKey = UrlItem(key: "api_key", value: "20273c51e3e2e33ccf30874850c5e3b5")
    let language = UrlItem(key: "language", value: "en-US")
    
    private func getURL(type: MovieType, id: String = "") -> String {
        switch type {
        case .upcoming: return baseURL.appending("movie/upcoming")
        case .nowPlaying: return baseURL.appending("movie/now_playing")
        case .topRated: return baseURL.appending("movie/top_rated")
        case .popular: return baseURL.appending("movie/popular")
        case .detail: return baseURL.appending("movie/\(id)")
        case .omdb: return "http://img.omdbapi.com/"
        case .credits: return baseURL.appending("movie/\(id)/credits")
        case .search: return baseURL.appending("search/movie")
        case .browseActor, .browseDirector: return baseURL.appending("person/\(id)/movie_credits")
        }
    }
    
    public func getUrlItems(movieType: MovieType, value: String = "") -> [UrlItem] {
        switch movieType {
        case .upcoming, .nowPlaying, .topRated, .popular:
            return [tmdbKey, language, UrlItem(key: "page", value: value)]
        case .detail: return [tmdbKey]
        case .omdb: return [omdpKey, UrlItem(key: "i", value: value)]
        case .credits, .browseActor, .browseDirector: return [tmdbKey, language]
        case .search: return [tmdbKey, UrlItem(key: "query", value: value)]
        }
    }
    
    public func buildURL(movieType: MovieType, id: String = "", value: String = "") -> String {
        var queryItems: [String : String] = [:]
        let urlString = getURL(type: movieType, id: id)
        let urlItems = getUrlItems(movieType: movieType, value: value)
        
        for item in urlItems {
            queryItems.updateValue(item.value, forKey: item.key)
        }
        
        guard var url = URL(string: urlString) else { return "Invalid URL" }
        url.buildURL(queries: queryItems)
        return url.absoluteString
    }
}
