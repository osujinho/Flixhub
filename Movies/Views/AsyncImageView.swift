//
//  AsyncImageView.swift
//  Movies
//
//  Created by Michael Osuji on 2/16/22.
//

import SwiftUI

struct AsyncImageView: View {
    let imagePath: String
    
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    var body: some View {
        AsyncImage(url: URL(string: imageBaseUrl.appending(imagePath))) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(5)
        } placeholder: {
            placeholderImage()
        }
    }
}

// placeholder
@ViewBuilder
func placeholderImage() -> some View {
    Image(systemName: "photo")
        .renderingMode(.template)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 150, height: 150)
        .foregroundColor(.gray)
        .overlay(
            ProgressView()
        )
}
