//
//  ShowDetailHeaderView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/1/22.
//

import SwiftUI

struct ShowDetailHeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var playTrailer: Bool
    let detail: ShowDetail
    let topPaddingSize: CGFloat
    let rated: String
    let noTrailerAlertOpacity: CGFloat
    let trailerID: String
    let checkForTrailer: @MainActor () -> ()
    
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
                .background(
                    RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 5)
                        .fill(.clear)
                )
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
                NavigationLink(destination: VideoPlayerView(videoID: trailerID), isActive: $playTrailer) {
                    
                    UrlImageView(path: detail.poster, defaultImage: .poster)
                        .frame(width: 100, height: 150)
                        .cornerRadius(5)
                        .overlay(
                            RatingView(rating: detail.rating, frameSize: 30)
                                .offset(x: 50, y: -25)
                        )
                        .padding(.top, -50)
                        .onTapGesture {
                            checkForTrailer()
                        }
                }
                
                VStack(alignment: .leading) {
                    Text(detail.name.capitalized)
                        .movieFont(style: .bold, size: movieAndShowTitleSize)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 5)
                    
                    Text(rated)
                        .foregroundColor(.secondary)
                        .movieFont(style: .regular, size: personDetailHeaderSize)
                    
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
            .background(Color("pickerColor"))
            .overlay(
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(Font.system(size: 20, weight: .bold))
                    Text("No Trailer Available!")
                        .movieFont(style: .bold, size: labelSize)
                }
                .foregroundColor(.orange)
                .opacity(noTrailerAlertOpacity)
                .offset(y: -150)
            )
        }
    }
}
