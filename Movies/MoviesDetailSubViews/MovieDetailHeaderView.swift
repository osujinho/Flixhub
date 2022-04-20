//
//  MovieDetailHeaderView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import SwiftUI

struct MovieDetailHeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    let detail: TMDBDetail
    let topPaddingSize: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            if !detail.images.backdrops.isEmpty {
                TabView {
                    ForEach(detail.images.backdrops, id: \.self){ image in
                        UrlImageView(path: image.path, defaultImage: .backdrop)
                    }
                }
                .frame(height: 250)
                .clipped()
                .cornerRadius(5)
                .padding(.top, -topPaddingSize)
                .tabViewStyle(PageTabViewStyle())
                .animation(.easeInOut, value: 1)
            } else {
                Rectangle()
                    .fill(Color("pickerColor"))
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .padding(.top, -topPaddingSize)
            }
            
            HStack(alignment: .lastTextBaseline, spacing: 20) {
                UrlImageView(path: detail.poster, defaultImage: .poster)
                    .frame(width: 100, height: 150)
                    .cornerRadius(5)
                    .overlay(
                        RatingView(rating: detail.rating, frameSize: 30)
                            .offset(x: 50, y: -25)
                    )
                    .padding(.top, -50)
                
                VStack(alignment: .leading) {
                    Text(detail.title)
                        .movieFont(style: .bold, size: movieAndShowTitleSize)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Text(getDate(date: detail.releaseDate,forYear: true))
                        Text("•")
                            .font(.system(size: 30))
                        Text(stringToTime(strTime: detail.runtime))
                    }
                    .foregroundColor(.secondary)
                    .movieFont(style: .regular, size: personDetailHeaderSize)
                }
                
                Spacer()
            }
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .padding(.horizontal, 10)
            .background(Color("pickerColor"))
        }
    }
}
