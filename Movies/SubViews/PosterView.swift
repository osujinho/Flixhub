//
//  PosterView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct PosterView: View {
    let imagePath: String?
    let title: String
    let rating: Double?
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 0.4)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        UrlImageView(path: imagePath, defaultImage: .poster)
            .frame(width: 120, height: 180)
            .overlay(
                ZStack(alignment: .bottom) {
                    UrlImageView(path: imagePath, defaultImage: .poster)
                        .frame(width: 120, height: 180)
                        .blur(radius: 20) /// blur the image
                        .padding(-20) /// expand the blur a bit to cover the edges
                        .padding(.bottom, 10)
                        .clipped() /// prevent blur overflow
                        .mask(gradient) /// mask the blurred image using the gradient's alpha values
                    
                    gradient /// also add the gradient as an overlay (this time, the purple will show up)
                    
                    VStack{
                        Spacer()
                        HStack {
                            RatingView(rating: rating, frameSize: 30)
                                .padding(.leading, 5)
                            Spacer()
                        }
                    }
                    .padding(.bottom, -18)
                }
            )
            .padding(.bottom, 70)
            .background(posterLabelColor)
            .overlay(
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(title)
                                .font(.caption2)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 5)
                            Spacer()
                        }
                    }
                    .background(posterLabelColor)
                }
                .padding(.bottom, 8)
            )
            .cornerRadius(5)
    }
}
