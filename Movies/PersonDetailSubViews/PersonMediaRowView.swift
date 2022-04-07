//
//  PersonMediaRowView.swift
//  Movies
//
//  Created by Michael Osuji on 3/15/22.
//

import SwiftUI

struct PersonMediaRowView: View {
    let poster: String?
    let mediaType: PersonCreditsOption
    let titleOrName: String
    let date: String?
    let charcterOrJob: String?
    let rating: Double?
    let genres: [Int]?
    let genreManager = GenreManager.genreManager
    let posterWidth: Double = 100
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 25) {
            UrlImageView(path: poster, defaultImage: .poster)
                .frame(width: CGFloat(posterWidth), height: CGFloat(posterWidth * 1.5))
                .cornerRadius(10)
                .overlay(
                    RatingView(rating: rating, frameSize: 30)
                        .offset(x: 50, y: -50)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(titleOrName.uppercased())
                    .multilineTextAlignment(.leading)
                    .movieFont(style: .bold, size: listRowTitleSize)
                
                switch mediaType {
                case .castMovies:
                    RowLabelAndInfoView(label: "released", info: getDate(date: date, forYear: false))
                    RowLabelAndInfoView(label: "character", info: charcterOrJob ?? "N/A")
                case .castShows:
                    RowLabelAndInfoView(label: "First Aired", info: getDate(date: date, forYear: false))
                    
                    RowLabelAndInfoView(label: "character", info: charcterOrJob ?? "N/A")
                case .crewMovies:
                    RowLabelAndInfoView(label: "released", info: getDate(date: date, forYear: false))
                    
                    RowLabelAndInfoView(label: "job", info: charcterOrJob ?? "N/A")
                case .crewShows:
                    RowLabelAndInfoView(label: "First Aired", info: getDate(date: date, forYear: false))
                   
                    RowLabelAndInfoView(label: "job", info: charcterOrJob ?? "N/A")
                } /// End of switch
                
                /// For genres
                HStack(alignment: .bottom) {
                    Text(genreManager.getGenre(genreID: genres).joined(separator: ", "))
                        .movieFont(style: .regular, size: bodySize)
                }
            }
            .foregroundColor(.primary)
        } /// End of HStack
        .padding(.bottom, 10)
    }
}
