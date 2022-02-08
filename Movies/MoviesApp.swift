//
//  MoviesApp.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

@main
struct MoviesApp: App {
    @StateObject private var viewModel = MoviesViewModel(networkManager: NetworkManager())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
