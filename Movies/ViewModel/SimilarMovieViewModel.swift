//
//  SimilarMovieViewModel.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import Foundation

@MainActor class SimilarMovieViewModel: ObservableObject {
    @Published var movies: [TMDBResult] = []
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
    var movieID: String = ""
    var currentMovie: TMDBResult?
    
    private var canLoadMore: Bool {
        currentPage <= totalPages ? true : false
    }
    
    func loadMoreMovieIfNeeded(currentMovie movie: TMDBResult?) async {
        guard let movie = movie else { return }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        
        if movies.firstIndex(where: { $0.tmdbID == movie.tmdbID }) == thresholdIndex {
            await self.loadMoreMovies()
        }
    }
    
    private func loadMoreMovies() async {
        guard !isLoading && canLoadMore else { return }
        
        self.fetchTask?.cancel()
        
        fetchTask = Task {
            self.hasError = false
            self.isLoading = true
            
            let url = urlManager.buildURL(movieType: .similarMovie, id: movieID ,value: String( currentPage ))
            
            do {
                let similar: MovieBrowseData = try await networkManager.makeCall(url: url)
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
    
    private func getUniqueResults(results: [TMDBResult]) {
        let currentMovies = Set(movies)
        let newMovies = Set(results)
        
        let uniqueResults = Array(newMovies.subtracting(currentMovies))
        movies.append(contentsOf: uniqueResults)
    }
}
