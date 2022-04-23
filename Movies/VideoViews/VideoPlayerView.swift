//
//  VideoPlayerView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/23/22.
//

import SwiftUI
import YouTubePlayerKit

struct VideoPlayerView: View {
    let videoID: String
        
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            YouTubePlayerView(
                .init(
                    source: .video(id: videoID),
                    configuration: .init(
                        isUserInteractionEnabled: true,
                        autoPlay: true,
                        playInline: false
                    )
                )
            )
        }
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") // Forcing the rotation to portrait
            AppDelegate.orientationLock = .landscape // And making sure it stays that way
        }.onDisappear {
            AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
        }
    }
}
