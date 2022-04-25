//
//  MoviesApp.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

@main
struct MoviesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appViewModel)
        }
    }
}
