//
//  VideoView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI
import YouTubePlayerKit

struct TrailerPlayer: View {
    @State private var playTrailer: Bool = false
    let videoID: String
    let clipHeightMultiplier: Double
    
    var body: some View {
        let clipHeight = UIScreen.main.bounds.height * clipHeightMultiplier
        
        Group {
            
            if playTrailer == false {
                ZStack {
                    TrailerOverlayView(
                        thumbnail: videoID,
                        clipHeightMultiplier: clipHeightMultiplier
                    )
                    
                    Button(action: {
                        withAnimation {
                            playTrailer = true
                        }
                    }) {
                        PlayButton()
                    }
                } /// End of ZStack
                
            } else {
                VStack {
                    YouTubePlayerView(
                        .init(
                            source: .video(id: videoID),
                            configuration: .init(
                                isUserInteractionEnabled: true,
                                autoPlay: true
                            )
                        )
                    )
                    .frame(width: 1.65 * clipHeight , height: clipHeight)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .overlay(alignment: .bottomLeading) {
                        Button(action: {     // To Stop the trailer
                            withAnimation {
                                playTrailer = false
                            }
                        }) {
                            Image(systemName: "stop.fill")
                        }
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .offset(x: 2, y: -15)
                    }
                }
            }
        }
    }
}

struct PlayButton: View {
    var body: some View {
        Image(systemName: "play.fill")
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(.red)
            .padding()
            .background(Color.black)
            .clipShape(Circle())
    }
}
