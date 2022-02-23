//
//  MoviesViewBuilder.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation

@MainActor class MoviesViewModel: ObservableObject {
    @Published var searchInput = UrlItem(key: "query", value: "")
    @Published private(set) var hasError: Bool = false
    @Published var errorMessage = ""
    @Published var pageNumber: String = "1"
    @Published var omdbDetail = UrlItem(key: "i", value: "")
    @Published var popular: [TMDBResult] = []
    
    private let networkManager: NetworkManager
    private let urlManager: URLManager
    
    init(networkManager: NetworkManager, urlManager: URLManager) {
        self.networkManager = networkManager
        self.urlManager = urlManager
    }
    
}

// Function to get the imageURL
func getImageUrl(_ path: String?) -> String {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    return imageBaseUrl.appending(path ?? "")
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
