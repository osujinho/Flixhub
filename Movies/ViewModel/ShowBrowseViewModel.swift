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
    
    //func fetchShows(type: )
    
}
