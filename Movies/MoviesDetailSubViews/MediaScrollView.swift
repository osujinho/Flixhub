//
//  MediaImagesScrollView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/31/22.
//

import SwiftUI

struct MediaScrollView: View {
    let posters: [String?]
    let videos: [VideoResults]
    let backdrops: [String?]
    let clipHeightMultiplier: Double = 0.25
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            // For videos
            if !videos.isEmpty {
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
                        
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .bottom, spacing: 10) {
                            ForEach(videos, id: \.self) { clip in
                                
                                VStack(alignment: .leading) {
                                    TrailerPlayer(videoID: clip.key, clipHeightMultiplier: clipHeightMultiplier)
                                    if let name = clip.name {
                                        Text(name)
                                            .movieFont(style: .bold, size: labelSize)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
            
            // Top for posters
            if !posters.isEmpty {
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
            }
            
            // For backdrops
            if !backdrops.isEmpty {
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
                        
                    }
                    
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
}
