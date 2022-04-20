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
    let videos: [VideoResults]
    let clipWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(videos, id: \.self) { clip in
                        VStack(alignment: .leading) {
                            YouTubePlayerView(
                                .init(
                                    source: .video(id: clip.key),
                                    configuration: .init(
                                        isUserInteractionEnabled: true
                                    )
                                )
                            )
                            .frame(width: clipWidth , height: clipWidth * 0.61)
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            if let name = clip.name {
                                Text(name)
                                    .movieFont(style: .bold, size: labelSize)
                                    .padding(.bottom, 10)
                            }
                        }
                        .padding(.top, 10)
                        .padding(.horizontal)
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
