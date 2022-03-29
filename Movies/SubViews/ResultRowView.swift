//
//  ResultRowView.swift
//  Movies
//
//  Created by Michael Osuji on 2/22/22.
//

import SwiftUI

struct ResultRowView: View {
    let poster: String?
    let mediaType: SearchMediaType
    let title: String
    let name: String
    let date: String?
    let knownFor: String?
    
    init(poster: String?, mediaType: SearchMediaType, title: String = "", name: String = "", date: String? = nil, knownFor: String? = nil) {
        self.poster = poster
        self.mediaType = mediaType
        self.title = title
        self.name = name
        self.date = date
        self.knownFor = knownFor
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            UrlImageView(path: poster, defaultImage: .poster)
                .frame(width: screen.width * 0.25)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title.uppercased())
                    .movieFont(style: .bold, size: listRowTitleSize)
                    .multilineTextAlignment(.leading)
                
                // For Showingg the date or department
                switch mediaType {
                case .movie: LabelAndInfoView(label: "released", info: getDate(date: date, forYear: false))
                case .show: LabelAndInfoView(label: "aired", info: getDate(date: date,forYear: false))
                case .person: LabelAndInfoView(label: "known for", info: knownFor ?? "N/A")
                }
                
                LabelAndInfoView(label: "media", info: mediaType.listRowLabel.uppercased())
            }
        }
    }
}
