//
//  ResultRowView.swift
//  Movies
//
//  Created by Michael Osuji on 2/22/22.
//

import SwiftUI

struct ResultRowView: View {
    let imageBaseUrl: String
    let movie: TMDBResult
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            AsyncImage(url: URL(string: imageBaseUrl.appending(movie.poster))) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 160)
                    .cornerRadius(10)
            } placeholder: {
                placeholderImage()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title)
                    .font(.system(size: 22, weight: .bold))
                Text(getDate(date: movie.releaseDate, forYear: true))
                    .font(.system(size: 13, weight: .bold))
            }
        }
    }
}
