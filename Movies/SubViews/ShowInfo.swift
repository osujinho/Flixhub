//
//  ShowInfo.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct ShowInfo: View {
    @Binding var playTrailer: Bool
    @Binding var synopsisExpanded: Bool
    let showDetail: ShowDetail
    
    var body: some View {
        HStack {
            HStack(alignment: .bottom) { /// Container for all
                if !synopsisExpanded {
                    UrlImageView(path: showDetail.poster, defaultImage: .poster)
                        .frame(width: detailPosterSize.width, height: detailPosterSize.height)
                }
                
                VStack(alignment: .leading) { /// For the Texts
                    HStack(alignment: .bottom) {
                        VStack {
                            Text(showDetail.name.uppercased())   /// Title
                                .movieFont(style: .title)
                                .foregroundColor(.white)
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
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.blue)
                        }
                    } /// End of title block HStack
                    
                    HStack(alignment: .bottom) { /// For type and status
                        
                        
                        HStack(spacing: 20) {
                            Text("Type:")
                                .movieFont(style: .label)
                            Text(showDetail.type?.capitalized ?? "N/A")
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Text("Status:")
                                .movieFont(style: .label)
                            Text(showDetail.status?.capitalized ?? "N/A")
                        }
                    }
                    
                    HStack(alignment: .bottom) {  /// For dates
                        HStack(spacing: 10) {
                            Text("Aired:")
                                .movieFont(style: .label)
                            Text(getDate(date: showDetail.firstAirDate ,forYear: false))
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Text("Ended:")
                                .movieFont(style: .label)
                            Text(getDate(date: showDetail.lastAirDate ,forYear: false))
                        }
                    }
                    
                    HStack(alignment: .bottom) {  /// For Seasons and Episodes
                        HStack(spacing: 20) {
                            Text("Seasons:")
                                .movieFont(style: .label)
                            Text(unwrapNumbersToString(showDetail.seasons))
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Text("Episodes:")
                                .movieFont(style: .label)
                            Text(unwrapNumbersToString(showDetail.episodes))
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack(alignment: .lastTextBaseline) { /// Stack for the genres
                        ForEach(showDetail.genres, id: \.self) { genre in
                            Text(genre.name.capitalized)
                                .genreTextViewModifier()
                        }
                    } /// End of stack for Genres
                } /// End of Texts VStack
                .movieFont(style: .body)
                .foregroundColor(.white)
                Spacer()  /// To make items aligned leading in a HStack
        
            } /// End of container for all
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
        }
    }
}


