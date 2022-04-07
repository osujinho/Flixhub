//
//  ImageBackgroundView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/5/22.
//

import SwiftUI

struct ImageBackgroundView: View {
    let imagePath: String?
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color("pickerColor"), location: 0),
            .init(color: .clear, location: 2.0)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )

    let backdropWidth = screen.width

    var body: some View {
        if imagePath != nil {
            UrlImageView(path: imagePath, defaultImage: .backdrop)
                .frame(width: backdropWidth, height: backdropWidth * 0.5625 )
                .overlay(
                    ZStack(alignment: .bottom) {
                        UrlImageView(path: imagePath, defaultImage: .backdrop)
                            .frame(width: backdropWidth, height: backdropWidth * 0.5625 )
                            .blur(radius: 20)
                            .padding(-20)
                            .padding(.bottom, 10)
                            .clipped()
                            .mask(gradient)
                        
                        gradient
                    }
                )
        } else {
            Rectangle()
                .fill(gradient)
                .frame(width: backdropWidth, height: backdropWidth * 0.5625 )
        }
    }
}
