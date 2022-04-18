//
//  MovieDetailTopView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/29/22.
//

import SwiftUI

struct MovieDetailTopView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var playTrailer: Bool
    let videoID: String
    let detail: TMDBDetail
    let rated: String
    let topSafeArea: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            // Trailer part
            TrailerPlayer(
                playTrailer: $playTrailer,
                videoID: videoID,
                backdrop: detail.backdrop
            )
            .scaledToFit()
            .if(playTrailer) { view in
                view
                    .padding(.top, -20)
                    .background(Color.black)
            }
            
            // Quick info part
            HStack(alignment: .lastTextBaseline, spacing: 20) {
                if !playTrailer {
                    NavigationLink(destination:
                                    ImageGallery(
                                        images: detail.images.posters.map { $0.path }, defaultImage: .poster)
                    ){
                        UrlImageView(path: detail.poster, defaultImage: .poster)
                            .frame(width: 100, height: 150)
                            .cornerRadius(5)
                            .overlay(
                                RatingView(rating: detail.rating, frameSize: 30)
                                    .offset(x: 50, y: -25)
                            )
                            .padding(.top, -50)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(detail.title)   /// Title
                        .movieFont(style: .bold, size: movieAndShowTitleSize)
                        .padding(.bottom, 5)
                        .multilineTextAlignment(.leading)
                    Text(rated)
                        .foregroundColor(.secondary)
                    HStack {
                        Text(getDate(date: detail.releaseDate, forYear: true))
                        Text("•")
                            .font(.system(size: 30))
                        Text(stringToTime(strTime: detail.runtime))
                        
                        Spacer()
                    }
                }
                .movieFont(style: .regular, size: personDetailHeaderSize)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                Spacer()
            }
            .padding(.horizontal, 10)
            .background(Color("pickerColor"))
        }
        .padding(.top, -topSafeArea)
    }
}



