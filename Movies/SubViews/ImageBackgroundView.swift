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
        let backdropHeight = (backdropWidth * 0.5625)
        if imagePath != nil {
            VStack(spacing: 0) {
                UrlImageView(path: imagePath, defaultImage: .backdrop)
                    .frame(width: backdropWidth, height: backdropHeight )
                    .overlay(
                        ZStack(alignment: .bottom) {
                            UrlImageView(path: imagePath, defaultImage: .backdrop)
                                .frame(width: backdropWidth, height: backdropHeight )
                                .blur(radius: 20)
                                .padding(-20)
                                .padding(.bottom, 10)
                                .clipped()
                                .mask(gradient)
                            
                            gradient
                        }
                    )
                Rectangle()
                    .fill(Color("pickerColor"))
                    .frame(width: backdropWidth, height: 60)
            }
        } else {
            Rectangle()
                .fill(gradient)
                .frame(width: backdropWidth, height: backdropHeight + 60)
        }
    }
}
