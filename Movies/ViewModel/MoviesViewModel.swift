//
//  MoviesViewBuilder.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation

@MainActor class MoviesViewModel: ObservableObject {
    @Published var title: String = ""
    @Published private(set) var viewState: ViewState = .notAvailable
    @Published var hasError: Bool = false
    @Published var errorMessage = ""
    
    private let networkManager: NetworkManager
    private let baseURL = "http://www.omdbapi.com/"
    private var queryItems = ["apiKey" : "4324aa3d"]
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // Add search item into query items dictionary
    private func buildSearchQuery() {
        queryItems.updateValue(title, forKey: "s")
        queryItems.removeValue(forKey: "i")
    }
    
    private func movieDetailQuery(imdbID: String) {
        queryItems.updateValue(imdbID, forKey: "i")
        queryItems.removeValue(forKey: "s")
    }
    
    // Function to seach for movies
    func searchMovie(forSearch: Bool, imdbID: String = "") async {
        self.viewState = .loadingSearchResult
        self.hasError = false
        
        forSearch ? buildSearchQuery() : movieDetailQuery(imdbID: imdbID)
        
        guard var url = URL(string: baseURL) else { return }
        url.buildURL(queries: queryItems)
        
        do {
            // load JSON Object
            if forSearch {
                let results: Search = try await networkManager.makeCall(url: url)
                self.viewState = .searchSuccessful(data: results)
            } else {
                let detail: Movie = try await networkManager.makeCall(url: url)
                self.viewState = .detailSuccessful(data: detail)
            }
        } catch {
            // Error in case data could not be loaded
            self.viewState = .failure(error: error)
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

enum ViewState {
    case notAvailable
    case loadingSearchResult
    case loadingMovieDetail
    case searchSuccessful(data: Search)
    case detailSuccessful(data: Movie)
    case failure(error: Error)
}

// string to date
func getDate(date: String, forYear: Bool) -> String {
    let oldDateFormatter = DateFormatter()
    oldDateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Convert string to date
    guard let oldDate = oldDateFormatter.date(from: date) else { return "0000-00-00" }
    
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
