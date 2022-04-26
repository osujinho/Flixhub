//
//  ResultRowView.swift
//  Movies
//
//  Created by Michael Osuji on 2/22/22.
//

import SwiftUI

// Results in search view
struct ResultRowView: View {
    @State private var vstackWidth: CGFloat = 0
    let poster: String?
    let resultType: SearchMediaType
    let title: String
    let name: String
    let date: String?
    let knownFor: String?
    let posterWidth: Double = 110
    
    init(poster: String?, mediaType: SearchMediaType, title: String = "", name: String = "", date: String? = nil, knownFor: String? = nil) {
        self.poster = poster
        self.resultType = mediaType
        self.title = title
        self.name = name
        self.date = date
        self.knownFor = knownFor
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            UrlImageView(path: poster, defaultImage: .poster)
                .frame(width: CGFloat(posterWidth), height: CGFloat(posterWidth * 1.5))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title.uppercased())
                    .movieFont(style: .bold, size: listRowTitleSize)
                    .multilineTextAlignment(.leading)
                
                // For Showingg the date or department
                switch resultType {
                case .movie: RowLabelAndInfoView(label: "released", info: getDate(date: date, forYear: false), width: vstackWidth)
                case .show: RowLabelAndInfoView(label: "aired", info: getDate(date: date,forYear: false), width: vstackWidth)
                case .person: RowLabelAndInfoView(label: "known for", info: knownFor ?? "N/A", width: vstackWidth)
                }
                
                RowLabelAndInfoView(label: "media", info: resultType.listRowLabel.uppercased(), width: vstackWidth)
            }
            .overlay(
                GeometryReader { proxy in
                    Color.clear.onAppear {
                        self.vstackWidth = proxy.size.width
                    }
                }
            )
            
        }
    }
}
