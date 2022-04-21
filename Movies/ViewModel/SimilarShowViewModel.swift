//
//  SimilarShowViewModel.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import Foundation

@MainActor class SimilarShowViewModel: ObservableObject {
    @Published var shows: [ShowResult] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = false
    @Published var presentGridView: Bool = false
    
    private let urlManager = URLManager.urlManager
    private let networkManager = NetworkManager.networkManager
    let genreManager = GenreManager.genreManager
    
    private var currentPage: Int = 2
    private var fetchTask: Task<Void, Never>?
    var totalPages: Int = 1
    var showID: String = ""
    var currentShow: ShowResult?
    
    private var canLoadMore: Bool {
        currentPage <= totalPages ? true : false
    }
    
    func loadMoreShowIfNeeded(currentShow show: ShowResult?) async {
        guard let show = show else { return }
        
        let thresholdIndex = shows.index(shows.endIndex, offsetBy: -5)
        
        if shows.firstIndex(where: { $0.id == show.id }) == thresholdIndex {
            await self.loadMoreShows()
        }
    }
    
    private func loadMoreShows() async {
        guard !isLoading && canLoadMore else { return }
        
        self.fetchTask?.cancel()
        
        fetchTask = Task {
            self.hasError = false
            self.isLoading = true
            
            let url = urlManager.buildURL(movieType: .similarShow, id: showID ,value: String( currentPage ))
            
            do {
                let similar: ShowBrowseData = try await networkManager.makeCall(url: url)
                getUniqueResults(results: similar.results)
                currentPage += 1
            } catch {
                errorMessage = error.localizedDescription
                print(error)
                self.hasError = true
            }
            if !Task.isCancelled {
                self.isLoading = false
            }
        }
    }
    
    private func getUniqueResults(results: [ShowResult]) {
        let currentShow = Set(shows)
        let newShow = Set(results)
        
        let uniqueResults = Array(newShow.subtracting(currentShow))
        shows.append(contentsOf: uniqueResults)
    }
}
