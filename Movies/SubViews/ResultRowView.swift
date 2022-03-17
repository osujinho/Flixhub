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
                .scaledToFit()
                .frame(width: screen.width * 0.25, height: screen.height * 0.15)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title.uppercased())
                    .movieFont(style: .name)
                
                // For Showingg the date or department
                HStack(alignment: .bottom, spacing: 20) {
                    switch mediaType {
                    case .movie:
                        Text("Released:")
                            .movieFont(style: .label)
                        
                        Text(getDate(date: date, forYear: false))
                    case .show:
                        Text("Aired:")
                            .movieFont(style: .label)
                        
                        Text(getDate(date: date,forYear: false))
                    case .person:
                        Text("Known For:")
                            .movieFont(style: .label)
                        
                        Text(knownFor ?? "N/A")
                    }
                }
                
                HStack(alignment: .bottom, spacing: 20) {
                    Text("Media:")
                        .movieFont(style: .label)
                    
                    Text(mediaType.listRowLabel.uppercased())
                }
            }
            .movieFont(style: .body)
        }
    }
}
