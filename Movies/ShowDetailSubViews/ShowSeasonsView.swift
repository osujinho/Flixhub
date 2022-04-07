//
//  ShowSeasonsView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/1/22.
//

import SwiftUI

struct ShowSeasonsView: View {
    let seasons: [Season]
    let posterWidth: Double = 80
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(seasons, id: \.self) { season in
                HStack(alignment: .lastTextBaseline, spacing: 10) {
                    UrlImageView(path: season.poster, defaultImage: .poster)
                        .frame(width: CGFloat(posterWidth), height: CGFloat(posterWidth * 1.5))
                        .cornerRadius(5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(season.name?.capitalized ?? "Season \(season.number)")
                            .movieFont(style: .bold, size: listRowTitleSize)
                        
                        Text(getDate(date: season.airDate, forYear: false))
                            .foregroundColor(.primary.opacity(0.7))
                        
                        if let episodeCount = season.totalEpisodes {
                            Text("\(episodeCount) Episodes")
                                .foregroundColor(.secondary)
                        }
                    }
                    .movieFont(style: .regular, size: labelSize)
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}
