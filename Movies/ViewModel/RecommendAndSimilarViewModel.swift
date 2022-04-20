//
//  RecommendAndSimilarViewModel.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import Foundation

@MainActor class RecommendAndSimilarViewModel: ObservableObject {
    @Published var recommendMovies: [TMDBResult] = []
    @Published var similarMovies: [TMDBResult] = []
    
    
}
