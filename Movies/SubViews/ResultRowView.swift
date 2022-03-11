//
//  ResultRowView.swift
//  Movies
//
//  Created by Michael Osuji on 2/22/22.
//

import SwiftUI

struct ResultRowView: View {
    let poster: String?
    let title: String
    let releaseDate: String?
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            UrlImageView(path: poster, defaultImage: .poster)
                .scaledToFit()
                .frame(height: 160)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title.uppercased())
                    .movieFont(size: 20)
                Text(getDate(date: releaseDate, forYear: true))
                    .movieFont(size: 14)
            }
        }
    }
}
