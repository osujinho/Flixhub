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
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            UrlImageView(path: poster, defaultImage: .poster)
                .frame(width: 110, height: 170)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack(alignment: .bottom) {
                    Text(titleOrName.uppercased())
                        .multilineTextAlignment(.leading)
                        .movieFont(style: .bold, size: personNameSize)
                    
                    Spacer()
                    
                    RatingView(rating: rating, frameSize: 35)
                }
                
                let type = mediaType.listLabel
                LabelAndInfoView(label: "media", info: type, forMedia: true)
                
                switch mediaType {
                case .castMovies:
                    LabelAndInfoView(label: "released", info: getDate(date: date, forYear: false))
                    
                    LabelAndInfoView(label: "character", info: charcterOrJob ?? "N/A")
                case .castShows:
                    LabelAndInfoView(label: "First Aired", info: getDate(date: date, forYear: false))
                    
                    LabelAndInfoView(label: "character", info: charcterOrJob ?? "N/A")
                case .crewMovies:
                    LabelAndInfoView(label: "released", info: getDate(date: date, forYear: false))
                    
                    LabelAndInfoView(label: "job", info: charcterOrJob ?? "N/A")
                case .crewShows:
                    LabelAndInfoView(label: "First Aired", info: getDate(date: date, forYear: false))
                   
                    LabelAndInfoView(label: "job", info: charcterOrJob ?? "N/A")
                } /// End of switch
                
                /// For genres
                HStack(alignment: .bottom) {
                    Text(genreManager.getGenre(genreID: genres).joined(separator: ", "))
                }
            }
        }
        .movieFont(style: .regular, size: bodySize)
        .padding(.horizontal, 10)
    }
}
