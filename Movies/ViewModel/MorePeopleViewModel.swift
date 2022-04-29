//
//  MorePeopleViewModel.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/29/22.
//

import Foundation

@MainActor class MorePeopleViewModel: ObservableObject {
    @Published var people: [PersonResult] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = false
    @Published var presentGridView: Bool = false
    
    private let urlManager = URLManager.urlManager
    private let networkManager = NetworkManager.networkManager
    
    private var currentPage: Int = 2
    private var fetchTask: Task<Void, Never>?
    var searchType: MovieType = .trendingPeople
    var totalPages: Int = 1
    var currentPerson: PersonResult?
    
    var canLoadMore: Bool {
        currentPage <= totalPages ? true : false
    }
    
    func loadMoreMovieIfNeeded(currentPerson person: PersonResult?) async {
        guard let person = person else { return }
        
        let thresholdIndex = people.index(people.endIndex, offsetBy: -5)
        
        if people.firstIndex(where: { $0.id == person.id }) == thresholdIndex {
            await self.loadMorePeople()
        }
    }
    
    private func loadMorePeople() async {
        guard !isLoading && canLoadMore else { return }
        
        self.fetchTask?.cancel()
        
        fetchTask = Task {
            self.hasError = false
            self.isLoading = true
            
            let url = urlManager.buildURL(movieType: searchType, value: String( currentPage ))
            
            do {
                let people: PersonData = try await networkManager.makeCall(url: url)
                getUniqueResults(results: people.results)
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
    
    private func getUniqueResults(results: [PersonResult]) {
        let currentPeople = Set(people)
        let newPeople = Set(results)
        
        let uniqueResults = Array(newPeople.subtracting(currentPeople))
        people.append(contentsOf: uniqueResults)
    }
}
