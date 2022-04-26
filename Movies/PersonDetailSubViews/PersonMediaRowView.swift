//
//  PersonMediaRowView.swift
//  Movies
//
//  Created by Michael Osuji on 3/15/22.
//

import SwiftUI

struct PersonMediaRowView: View {
    @State private var vstackWidth: CGFloat = 0
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
                    RowLabelAndInfoView(label: "released", info: getDate(date: date, forYear: false), width: vstackWidth)
                    RowLabelAndInfoView(label: "character", info: charcterOrJob ?? "N/A", width: vstackWidth)
                case .castShows:
                    RowLabelAndInfoView(label: "First Aired", info: getDate(date: date, forYear: false), width: vstackWidth)
                    
                    RowLabelAndInfoView(label: "character", info: charcterOrJob ?? "N/A", width: vstackWidth)
                case .crewMovies:
                    RowLabelAndInfoView(label: "released", info: getDate(date: date, forYear: false), width: vstackWidth)
                    
                    RowLabelAndInfoView(label: "job", info: charcterOrJob ?? "N/A", width: vstackWidth)
                case .crewShows:
                    RowLabelAndInfoView(label: "First Aired", info: getDate(date: date, forYear: false), width: vstackWidth)
                   
                    RowLabelAndInfoView(label: "job", info: charcterOrJob ?? "N/A", width: vstackWidth)
                } /// End of switch
                
                /// For genres
                HStack(alignment: .bottom) {
                    Text(genreManager.getGenre(genreID: genres).joined(separator: ", "))
                        .movieFont(style: .regular, size: bodySize)
                }
            } /// end of VStack
            .foregroundColor(.primary)
            .overlay(
                GeometryReader { proxy in
                    Color.clear.onAppear {
                        self.vstackWidth = proxy.size.width
                    }
                }
            )
        } /// End of HStack
        .padding(.bottom, 10)
    }
}
