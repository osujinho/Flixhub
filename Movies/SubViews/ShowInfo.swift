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
    let gridCollections: [GridCollection]
    
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
                                .movieFont(style: .name)
                                .foregroundColor(.white)
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
                    .padding(.bottom, -5)
                    
                    VStack { /// For infor Grid
                        DetailInfoGridView(gridCollections: gridCollections)
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


