//
//  GetMoreViewModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/18/22.
//

import Foundation

@MainActor class GetMoreViewModel: ObservableObject {
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
    var movieType: MovieType = .upcoming
    var totalPages: Int = 1
    var currentMovie: TMDBResult?
    
    var canLoadMore: Bool {
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
            
            let url = urlManager.buildURL(movieType: movieType, value: String( currentPage ))
            
            do {
                switch movieType {
                case .upcoming, .nowPlaying, .popular, .topRated, .trendingMovies:
                    let loadedData: MovieBrowseData = try await networkManager.makeCall(url: url)
                    getUniqueResults(results: loadedData.results)
                
                default:
                    self.isLoading = false
                    return
                }
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

