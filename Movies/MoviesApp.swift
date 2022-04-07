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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
