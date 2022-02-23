//
//  PosterView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct PosterView: View {
    let imageUrl: String
    let titleOrDate: String
    let isPoster: Bool
    
    var body: some View {
        
        let gradient = LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .black, location: 0),
                .init(color: .clear, location: 0.4)
            ]),
            startPoint: .bottom,
            endPoint: .top
        )
        
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: isPoster ? 150 : 230)
                .overlay(
                    ZStack(alignment: .bottom) {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .frame(width: isPoster ? 150 : 230)
                                .blur(radius: 20) /// blur the image
                                .padding(-20) /// expand the blur a bit to cover the edges
                                .clipped() /// prevent blur overflow
                                .mask(gradient) /// mask the blurred image using the gradient's alpha values
                        } placeholder: {
                            placeholderImage()
                        }
                        
                        gradient /// also add the gradient as an overlay (this time, the purple will show up)
                        
                        HStack {
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(isPoster ? getDate(date: titleOrDate, forYear: false) : titleOrDate)
                                    .font(.system(size: isPoster ? 12 : 18, weight: .bold))
                                    .opacity(isPoster ? 0.75 : 1)
                                    .padding(.bottom, 1)
                            }
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    }
                )
        } placeholder: {
            placeholderImage()
        }
    }
}
