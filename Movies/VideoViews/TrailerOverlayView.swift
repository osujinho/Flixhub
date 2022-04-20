//
//  TrailerOverlayView.swift
//  Movies
//
//  Created by Michael Osuji on 2/24/22.
//

import SwiftUI

struct TrailerOverlayView: View {
    let thumbnail: String?
    let clipHeightMultiplier: Double
    
    /// For the Gradient
    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.black.opacity(0.7), location: 0),
            .init(color: .clear, location: 0.4)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        let clipHeight = UIScreen.main.bounds.height * clipHeightMultiplier
        
        UrlImageView(path: thumbnail, defaultImage: .backdrop, forThumbnail: true)
            .frame(width: 1.65 * clipHeight , height: clipHeight)
            .clipped()
            .overlay(
                ZStack(alignment: .bottom) {
                    UrlImageView(path: thumbnail, defaultImage: .backdrop, forThumbnail: true)
                        .frame(width: 1.65 * clipHeight , height: clipHeight)
                        .blur(radius: 20)
                        .padding(-20)
                        .clipped()
                        .mask(gradient)
                    
                    gradient
                    
                } /// End of overlay Zstack
            ) /// End of Overlay
            .cornerRadius(12)
    }
}
