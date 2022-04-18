//
//  MediaImagesScrollView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/31/22.
//

import SwiftUI
import YouTubePlayerKit

struct MediaScrollView: View {
    let posters: [String?]
    let videos: [VideoResults]
    let backdrops: [String?]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            // For videos
            VStack(alignment: .leading) {
                HStack {
                    Text("Videos")
                        .movieFont(style: .bold, size: labelSize)
                    Spacer()
                    
                    NavigationLink(destination:
                                    VideoGallery(videos: videos)
                    ){
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10))
                    }
                    
                }.padding(.horizontal)
                
                TabView{
                    ForEach(videos.filter{ $0.site.lowercased() == "youtube" }, id: \.self) { video in
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
            .padding(.top)
            .padding(.horizontal)
            
            // Top for posters
            VStack(alignment: .leading) {
                HStack {
                    Text("Posters")
                        .movieFont(style: .bold, size: labelSize)
                    Spacer()
                    
                    NavigationLink(destination:
                                    ImageGallery(
                                        images: posters,
                                        defaultImage: .poster)
                    ){
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10))
                    }
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .bottom, spacing: 10) {
                        ForEach(posters, id: \.self) { poster in
                            NavigationLink(destination:
                                            ImageFullView(path: poster, defaultImage: .poster)
                            ){
                                UrlImageView(path: poster, defaultImage: .poster)
                                    .frame(width: 200, height: 300)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            // For backdrops
            VStack(alignment: .leading) {
                HStack {
                    Text("Backdrops")
                        .movieFont(style: .bold, size: labelSize)
                    Spacer()
                    
                    NavigationLink(destination:
                                    ImageGallery(
                                        images: backdrops,
                                        defaultImage: .backdrop)
                    ){
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10))
                    }
                    
                }.padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .bottom, spacing: 10) {
                        ForEach(backdrops, id: \.self) { backdrop in
                            NavigationLink(destination:
                                            ImageFullView(path: backdrop, defaultImage: .backdrop)
                            ){
                                UrlImageView(path: backdrop, defaultImage: .backdrop)
                                    .frame(width: 300, height: 170)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}
