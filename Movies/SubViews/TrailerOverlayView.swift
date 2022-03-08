//
//  TrailerOverlayView.swift
//  Movies
//
//  Created by Michael Osuji on 2/24/22.
//

import SwiftUI

struct TrailerOverlayView: View {
    let backdrop: String?
    
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
        UrlImageView(path: backdrop)
            .clipped()
            .overlay(
                ZStack(alignment: .bottom) {
                    UrlImageView(path: backdrop)
                        .blur(radius: 20)
                        .padding(-20)
                        .clipped()
                        .mask(gradient)
                    
                    gradient
                    
                } /// End of overlay Zstack
            ) /// End of Overlay
    }
}
