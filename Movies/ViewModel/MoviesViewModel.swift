//
//  MoviesViewBuilder.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation

@MainActor class MoviesViewModel: ObservableObject {
    @Published var searchInput = UrlItem(key: "query", value: "")
    @Published var hasError: Bool = false
    @Published var errorMessage = ""
    @Published var pageNumber = UrlItem(key: "page", value: "1")
    @Published var omdbDetail = UrlItem(key: "i", value: "")
    
    private let networkManager: NetworkManager
    private let baseURL = "https://api.themoviedb.org/3/"
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    private let tmdbKey = UrlItem(key: "api_key", value: "20273c51e3e2e33ccf30874850c5e3b5")
    private let omdpKey = UrlItem(key: "apikey", value: "4324aa3d")
    private let language = UrlItem(key: "language", value: "en-US")
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    private func getURL(forMovie: GetFrom, id: Int = 0) -> String {
        switch forMovie {
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
    
    private func getUrlItems(forMovie: GetFrom) -> [UrlItem] {
        switch forMovie {
        case .upcoming, .nowPlaying, .topRated, .popular:
            return [tmdbKey, language, pageNumber]
        case .detail: return [tmdbKey]
        case .omdb: return [omdpKey, omdbDetail]
        case .credits, .browseActor, .browseDirector: return [tmdbKey, language]
        case .search: return [tmdbKey, searchInput]
        }
    }
    
    // Function to build URL
    func buildURL(forMovie: GetFrom, id: Int = 0) -> String {
        var queryItems: [String : String] = [:]
        let inputUrl = getURL(forMovie: forMovie, id: id)
        let urlItems = getUrlItems(forMovie: forMovie)
        
        for item in urlItems {
            queryItems.updateValue(item.value, forKey: item.key)
        }
        
        guard var url = URL(string: inputUrl) else { return "Invalid URL" }
        url.buildURL(queries: queryItems)
        return url.absoluteString
    }
    
    // Function to seach for movies
    func networkCall(forMovie: GetFrom, id: Int = 0) async -> ReturnType {
        self.hasError = false
        
        let url = buildURL(forMovie: forMovie, id: id)
        
        do {
            // load JSON Object
            switch forMovie {
            case .upcoming:
                let movies: Upcoming = try await networkManager.makeCall(url: url)
                return ReturnType.upcoming(movies: movies)
            case .nowPlaying:
                let movies: NowPlaying = try await networkManager.makeCall(url: url)
                return ReturnType.nowPlaying(movies: movies)
            case .topRated:
                let movies: TopRated = try await networkManager.makeCall(url: url)
                return ReturnType.topRated(movies: movies)
            case .popular:
                let movies: Popular = try await networkManager.makeCall(url: url)
                return ReturnType.popular(movies: movies)
            case .detail:
                let movies: TMDBDetail = try await networkManager.makeCall(url: url)
                return ReturnType.detail(movie: movies)
            case .omdb:
                let movies: OMDBDetail = try await networkManager.makeCall(url: url)
                return ReturnType.omdb(movie: movies)
            case .credits:
                let movies: CastDetail = try await networkManager.makeCall(url: url)
                return ReturnType.credits(credit: movies)
            case .search:
                let movies: TMDBSearch = try await networkManager.makeCall(url: url)
                return ReturnType.search(result: movies)
            case .browseActor:
                let movies: BrowseActor = try await networkManager.makeCall(url: url)
                return ReturnType.browseActor(results: movies)
            case .browseDirector:
                let movies: BrowseDirector = try await networkManager.makeCall(url: url)
                return ReturnType.browseDirector(results: movies)
            }
            
        } catch {
            // Error in case data could not be loaded
            errorMessage = error.localizedDescription
            self.hasError = true
        }
    }
    
    // function to build an array from comma seperated string
    func buildArray(from sentence: String) -> [String] {
        sentence.components(separatedBy: ", ")
    }
    
    // Get director from Crew array
    func getDirectors(castDetail: CastDetail) -> [Crew] {
        castDetail.crew.filter { $0.job == "Director" }
    }
}

// string to date
func getDate(date: String, forYear: Bool) -> String {
    let oldDateFormatter = DateFormatter()
    oldDateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Convert string to date
    guard let oldDate = oldDateFormatter.date(from: date) else { return "2000-01-01" }
    
    // convert date back to string in year format
    let newDateFormater = DateFormatter()
    newDateFormater.dateFormat = forYear ? "yyyy" : "MMM dd yyyy"
    
    return newDateFormater.string(from: oldDate)
}

// string to time
func stringToTime(strTime: String) -> String {
    guard let totalMinutes = Double(strTime) else { return strTime }
    
    let hours = Int(floor(totalMinutes / 60))
    let minutes = Int(totalMinutes) % 60
    
    return "\(hours)h \(minutes)mins"
}
