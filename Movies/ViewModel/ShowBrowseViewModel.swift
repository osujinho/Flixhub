//
//  ShowBrowseViewModel.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/21/22.
//

import Foundation

@MainActor class ShowBrowseViewModel: ObservableObject {
    @Published private(set) var airingToday = ShowBrowseData(results: [], total_pages: 0)
    @Published private(set) var onTheAir = ShowBrowseData(results: [], total_pages: 0)
    @Published private(set) var popularShows = ShowBrowseData(results: [], total_pages: 0)
    @Published private(set) var topRatedShows = ShowBrowseData(results: [], total_pages: 0)
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = true
    @Published private(set) var errorMessage: String = ""
    
    private let urlManager = URLManager.urlManager
    private let networkManager = NetworkManager.networkManager
    
    func fetchShows() async {
        self.hasError = false
        self.isLoading = true
        
        let airingTodayURL = urlManager.buildURL(movieType: .airingToday, value: "1")
        let onTheAirURL = urlManager.buildURL(movieType: .onTheAir, value: "1")
        let popularURL = urlManager.buildURL(movieType: .popularShows, value: "1")
        let topRatedURL = urlManager.buildURL(movieType: .topRatedShows, value: "1")
        
        do {
            airingToday = try await networkManager.makeCall(url: airingTodayURL)
            onTheAir = try await networkManager.makeCall(url: onTheAirURL)
            popularShows = try await networkManager.makeCall(url: popularURL)
            topRatedShows = try await networkManager.makeCall(url: topRatedURL)
        } catch {
            errorMessage = error.localizedDescription
            print(error)
            self.hasError = true
        }
        
        self.isLoading = false
    }
    
}
