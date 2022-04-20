//
//  VideoView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI
import WebKit
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

//struct VideoView: UIViewRepresentable {
//    let videoID: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        <#code#>
//    }
//}
