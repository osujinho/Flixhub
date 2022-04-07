//
//  MovieTitleAndGenreView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI

struct MovieDetailInfoView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var playTrailer: Bool
    let rated: String
    let detail: TMDBDetail
    
    var body: some View {
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
                            VStack{
                                HStack{
                                    Spacer()
                                    
                                    RatingView(rating: detail.rating, frameSize: 25)
                                }
                                Spacer()
                            }
                            .padding(.top, -15)
                        )
                }
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            Text(detail.title)   /// Title
                                .movieFont(style: .bold, size: movieAndShowTitleSize)
                                .padding(.bottom, 5)
                                .lineLimit(nil)
                        } /// Embed in a VStack so it can expand
                        
                        Spacer()
                        
                        if playTrailer {
                            Button(action: {     // To Stop the trailer
                                withAnimation {
                                    playTrailer = false
                                }
                            }) {
                                Image(systemName: "stop.fill")
                            }
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.blue)
                        }
                    }
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
            }
            Spacer()
        }
        .padding(.horizontal, 5)
        .background(Color("pickerColor"))
    }
}

