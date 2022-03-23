//
//  MovieType.swift
//  Movies
//
//  Created by Michael Osuji on 2/18/22.
//

import Foundation

struct UrlItem {
    let key: String
    let value: String
}

enum MovieType: CaseIterable {
    case upcoming, nowPlaying, topRated, popular, movieDetail, omdb, search, personDetail, showDetail, similar, recommended
}

class URLManager {
    static let urlManager = URLManager()
    
    private init() { }
    
    private let baseURL = "https://api.themoviedb.org/3/"
    private let omdpKey = UrlItem(key: "apikey", value: "4324aa3d")
    private let tmdbKey = UrlItem(key: "api_key", value: "20273c51e3e2e33ccf30874850c5e3b5")
    private let language = UrlItem(key: "language", value: "en-US")
    private let videoAndCredits = UrlItem(key: "append_to_response", value: "credits,videos,images")
    private let combinedCredits = UrlItem(key: "append_to_response", value: "combined_credits,images")
    private let getImages = UrlItem(key: "include_image_language", value: "en,null")
    
    private func getURL(type: MovieType, id: String = "") -> String {
        switch type {
        case .upcoming: return baseURL.appending("movie/upcoming")
        case .nowPlaying: return baseURL.appending("movie/now_playing")
        case .topRated: return baseURL.appending("movie/top_rated")
        case .popular: return baseURL.appending("movie/popular")
        case .movieDetail: return baseURL.appending("movie/\(id)")
        case .omdb: return "http://www.omdbapi.com/"
        case .search: return baseURL.appending("search/multi")
        case .personDetail: return baseURL.appending("person/\(id)")
        case .showDetail: return baseURL.appending("tv/\(id)")
        case .similar: return baseURL.appending("movie/\(id)/similar")
        case .recommended: return baseURL.appending("movie/\(id)/recommendations")
        }
    }
    
    private func getUrlItems(movieType: MovieType, value: String = "") -> [UrlItem] {
        switch movieType {
        case .upcoming, .nowPlaying, .topRated, .popular:
            return [tmdbKey, language, UrlItem(key: "page", value: value)]
        case .movieDetail: return [tmdbKey, videoAndCredits, getImages]
        case .omdb: return [omdpKey, UrlItem(key: "i", value: value)]
        case .personDetail: return [tmdbKey, language, combinedCredits, getImages]
        case .search: return [tmdbKey, UrlItem(key: "query", value: value)]
        case .showDetail: return [tmdbKey, language, videoAndCredits, getImages]
        case .recommended, .similar: return [tmdbKey, language, UrlItem(key: "page", value: value)]
            
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


//VStack(alignment: .leading, spacing: 3) {
//    if !viewModel.searchText.isEmpty {
//        switch viewModel.searchMediaType {
//        case .movie:
//            
//        case .show:
//            
//        case .person:
//            
//        } /// End of switch
//    }
//    
//    if viewModel.isSearching {
//        ProgressView()
//    }
//} /// End of VStack
