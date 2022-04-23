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
            Color("background")
            
            YouTubePlayerView(
                .init(
                    source: .video(id: videoID),
                    configuration: .init(
                        isUserInteractionEnabled: true,
                        autoPlay: true
                    )
                )
            )
        }
    }
}
