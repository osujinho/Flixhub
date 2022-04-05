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
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            UrlImageView(path: show.poster, defaultImage: .poster)
                .scaledToFill()
                .frame(width: 110, height: 170)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    RatingView(rating: show.rating, frameSize: 35)
                        .padding(.top, 5)
                }
                Spacer()
                
                Text(show.name.uppercased())
                    .movieFont(style: .bold, size: listRowTitleSize)
                
                Text(getDate(date: show.date ,forYear: false))
                    .movieFont(style: .regular, size: labelSize)
                
                HStack(alignment: .bottom) {
                    Text(genreManager.getGenre(genreID: show.genres).joined(separator: ", "))
                        .movieFont(style: .light, size: petiteSize)
                        .opacity(0.7)
                }
            }
        }
    }
}
