//
//  MoreShowRowView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/4/22.
//

import SwiftUI

struct MoreShowRowView: View {
    let show: ShowResult
    let genreManager = GenreManager.genreManager
    let posterWidth: Double = 100
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            UrlImageView(path: show.poster, defaultImage: .poster)
                .frame(width: CGFloat(posterWidth), height: CGFloat(posterWidth * 1.5))
                .cornerRadius(10)
                .overlay(
                    RatingView(rating: show.rating, frameSize: 30)
                        .offset(x: 50, y: -50)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(show.name)
                    .movieFont(style: .bold, size: listRowTitleSize)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 10)
                
                Text(getDate(date: show.date ,forYear: false))
                    .movieFont(style: .regular, size: labelSize)
                
                HStack(alignment: .bottom) {
                    Text(genreManager.getGenre(genreID: show.genres).joined(separator: ", "))
                        .movieFont(style: .light, size: petiteSize)
                        .opacity(0.7)
                }
            }
            .foregroundColor(.primary)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}
