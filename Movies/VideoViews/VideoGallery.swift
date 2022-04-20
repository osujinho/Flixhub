//
//  VideoGallery.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/4/22.
//

import SwiftUI

struct VideoGallery: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let videos: [VideoResults]
    let clipHeightMultiplier: Double = 0.26
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(videos, id: \.self) { clip in
                        VStack(alignment: .leading) {
                            TrailerPlayer(videoID: clip.key, clipHeightMultiplier: clipHeightMultiplier)
                            
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
