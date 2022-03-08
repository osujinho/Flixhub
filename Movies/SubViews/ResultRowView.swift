//
//  ResultRowView.swift
//  Movies
//
//  Created by Michael Osuji on 2/22/22.
//

import SwiftUI

struct ResultRowView: View {
    let movie: TMDBResult
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            UrlImageView(path: movie.poster)
                .frame(height: 160)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title)
                    .font(.system(size: 22, weight: .bold))
                Text(getDate(date: movie.releaseDate, forYear: true))
                    .font(.system(size: 13, weight: .bold))
            }
        }
    }
}
