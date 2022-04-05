//
//  VideoGallery.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/4/22.
//

import SwiftUI
import YouTubePlayerKit

struct VideoGallery: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let videos: [(name: String?, key: String)]
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(videos, id: \.key) { video in
                        VStack(alignment: .leading) {
                            YouTubePlayerView(
                                YouTubePlayer(
                                    source: .video(id: video.key),
                                    configuration: .init(
                                        autoPlay: false,
                                        playInline: true
                                    )
                                )
                            )
                            if let name = video.name {
                                Text(name)
                                    .movieFont(style: .bold, size: labelSize)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .renderingMode(.original)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                })
            }
        }
    }
}
