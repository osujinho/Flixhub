//
//  MovieDetailTopView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/29/22.
//

import SwiftUI

struct MovieDetailTopView: View {
    @Binding var playTrailer: Bool
    let videoID: String
    let movieDetail: TMDBDetail
    let rated: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Trailer part
            TrailerPlayer(
                playTrailer: $playTrailer,
                videoID: videoID,
                backdrop: movieDetail.backdrop
            )
            .scaledToFit()
            .if(playTrailer) { view in
                view
                    .padding(.top, -50)
                    .padding(.bottom, 25)
            }
            
            // Quick info part
            MovieDetailInfoView(
                playTrailer: $playTrailer,
                rated: rated,
                detail: movieDetail)
        }
    }
}



