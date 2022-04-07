//
//  AppDelegate.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/5/22.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UIScrollView.appearance().bounces = false
        
        return true
    }
}
