//
//  VideoView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI
import YouTubePlayerKit

struct TrailerPlayer: View {
    @Binding var playTrailer: Bool
    let videoID: String
    let backdrop: String?
    
    var body: some View {
        Group {
            if playTrailer == false {
                ZStack {
                    TrailerOverlayView(backdrop: backdrop)
                    
                    Button(action: {
                        withAnimation {
                            playTrailer = true
                        }
                    }) {
                        Image(systemName: "play.fill")
                    }
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.red)
                } /// End of ZStack
                .frame(height: screen.height * 0.35)
            } else {
                VStack {
                    YouTubePlayerView(
                        YouTubePlayer(
                            source: .video(id: videoID),
                            configuration: .init(
                                autoPlay: true,
                                playInline: true
                            )
                        )
                    )
                }
            }
        }
    }
}
