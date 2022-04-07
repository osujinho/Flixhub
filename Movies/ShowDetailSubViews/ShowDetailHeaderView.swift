//
//  ShowDetailHeaderView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/1/22.
//

import SwiftUI

struct ShowDetailHeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    let detail: ShowDetail
    let topPaddingSize: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
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
            
            HStack(alignment: .lastTextBaseline) {
                UrlImageView(path: detail.poster, defaultImage: .poster)
                    .frame(width: 100, height: 150)
                    .cornerRadius(5)
                    .overlay(
                        RatingView(rating: detail.rating, frameSize: 30)
                            .offset(x: 50, y: -25)
                    )
                    .padding(.top, -50)
                
                VStack(alignment: .leading) {
                    Text(detail.name.capitalized)
                        .movieFont(style: .bold, size: movieAndShowTitleSize)
                    HStack {
                        Text(getDate(date: detail.firstAirDate,forYear: true))
                        Text("•")
                            .font(.system(size: 30))
                        Text(detail.status?.capitalized ?? "No Status")
                    }
                    .foregroundColor(.secondary)
                    .movieFont(style: .regular, size: personDetailHeaderSize)
                }
                
                Spacer()
            }
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .padding(.horizontal, 10)
        }
    }
}
