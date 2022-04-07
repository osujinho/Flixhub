//
//  AirEpisode.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/1/22.
//

import SwiftUI

struct AirEpisode: View {
    let episode: Episode
    let label: String
    let posterWidth: Double = 50
    let widthPercent: Double = 0.5
    
    var body: some View {
        let labelWidth = label.widthOfString(usingFont: UIFont.systemFont(ofSize: 16, weight: .bold))
        let spacingSize = (screen.width * widthPercent) - labelWidth
        
        HStack(alignment: .top, spacing: spacingSize) {
            Text(label.capitalized)
                .movieFont(style: .bold, size: labelSize)
                .foregroundColor(.secondary)
            
            HStack(alignment: .lastTextBaseline, spacing: 10) {
                UrlImageView(path: episode.poster, defaultImage: .poster)
                    .frame(width: CGFloat(posterWidth), height: CGFloat(posterWidth * 1.5))
                    .cornerRadius(5)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(episode.name?.capitalized ?? "Episode \(episode.episodeNumber)")
                        .movieFont(style: .bold, size: bodySize)
                        .padding(.bottom, 5)
                    
                    Text(getDate(date: episode.airDate, forYear: false))
                        .foregroundColor(.primary.opacity(0.7))
                    
                    HStack{
                        Text("Se \(episode.seasonNumber)")
                        Text("•")
                            .font(.system(size: 30))
                        Text("Ep \(episode.episodeNumber)")
                    }
                    .foregroundColor(.secondary)
                }
                Spacer()
            }
            .movieFont(style: .regular, size: petiteSize)
        }
        .padding(.horizontal)
    }
}
