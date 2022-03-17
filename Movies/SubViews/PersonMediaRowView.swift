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
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            UrlImageView(path: poster, defaultImage: .poster)
                .frame(width: listPosterSize.width, height: listPosterSize.height)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(titleOrName.uppercased())
                    .movieFont(style: .name)
                
                HStack(alignment: .bottom, spacing: 20) {
                    Text("Media:")
                        .movieFont(style: .label)
                    
                    let type = mediaType.listLabel
                    Text(type)
                        .foregroundColor(type.lowercased() == "movies" ? .blue.opacity(0.8) : .yellow.opacity(0.8))
                }
                
                switch mediaType {
                case .castMovies:
                    HStack(alignment: .bottom, spacing: 20) {
                        Text("Released")
                            .movieFont(style: .label)
                        
                        Text(getDate(date: date, forYear: false))
                    }
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        Text("Character")
                            .movieFont(style: .label)
                        
                        Text(charcterOrJob ?? "N/A")
                    }
                case .castShows:
                    HStack(alignment: .bottom, spacing: 20) {
                        Text("First Aired")
                            .movieFont(style: .label)
                        
                        Text(getDate(date: date, forYear: false))
                    }
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        Text("Character")
                            .movieFont(style: .label)
                        Text(charcterOrJob ?? "N/A")
                    }
                case .crewMovies:
                    HStack(alignment: .bottom, spacing: 20) {
                        Text("Released")
                            .movieFont(style: .label)
                        
                        Text(getDate(date: date, forYear: false))
                    }
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        Text("Job")
                            .movieFont(style: .label)
                        
                        Text(charcterOrJob ?? "N/A")
                    }
                case .crewShows:
                    HStack(alignment: .bottom, spacing: 20) {
                        Text("First Aired")
                            .movieFont(style: .label)
                        
                        Text(getDate(date: date, forYear: false))
                    }
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        Text("Job")
                            .movieFont(style: .label)
                        Text(charcterOrJob ?? "N/A")
                    }
                }
            }
        }
        .movieFont(style: .body)
    }
}
