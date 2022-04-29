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
    case upcoming, nowPlaying, topRated, popular, movieDetail, omdb, search, personDetail, showDetail, similarMovie, recommendMovies, showRatings, similarShow, recommendShow, taggedImages, movieRelease, airingToday, onTheAir, popularShows, topRatedShows, trendingMovies, trendingShows, trendingPeople
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
    private let region = UrlItem(key: "region", value: "us")
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
        case .similarMovie: return baseURL.appending("movie/\(id)/similar")
        case .recommendMovies: return baseURL.appending("movie/\(id)/recommendations")
        case .showRatings: return baseURL.appending("tv/\(id)/content_ratings")
        case .similarShow: return baseURL.appending("tv/\(id)/similar")
        case .recommendShow: return baseURL.appending("tv/\(id)/recommendations")
        case .taggedImages: return baseURL.appending("person/\(id)/tagged_images")
        case .movieRelease: return baseURL.appending("movie/\(id)/release_dates")
        case .airingToday: return baseURL.appending("tv/airing_today")
        case .onTheAir: return baseURL.appending("tv/on_the_air")
        case .popularShows: return baseURL.appending("tv/popular")
        case .topRatedShows: return baseURL.appending("tv/top_rated")
        case .trendingMovies: return baseURL.appending("trending/movie/week")
        case .trendingShows: return baseURL.appending("trending/tv/week")
        case .trendingPeople: return baseURL.appending("trending/person/week")
        }
    }
    
    private func getUrlItems(movieType: MovieType, value: String = "") -> [UrlItem] {
        switch movieType {
        case .recommendMovies, .similarMovie, .similarShow, .recommendShow, .taggedImages, .airingToday, .onTheAir, .popularShows, .topRatedShows:
            return [tmdbKey, language, UrlItem(key: "page", value: value)]
        case .upcoming, .nowPlaying, .popular, .topRated: return [tmdbKey, language, region, UrlItem(key: "page", value: value)]
        case .movieDetail: return [tmdbKey, videoAndCredits, getImages]
        case .omdb: return [omdpKey, UrlItem(key: "i", value: value)]
        case .personDetail: return [tmdbKey, language, combinedCredits, getImages]
        case .search: return [tmdbKey, UrlItem(key: "query", value: value)]
        case .showDetail: return [tmdbKey, language, videoAndCredits, getImages]
        case .showRatings: return [tmdbKey, language]
        case .movieRelease: return [tmdbKey]
        case .trendingMovies, .trendingPeople, .trendingShows: return [tmdbKey, UrlItem(key: "page", value: value)]
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
