//
//  Result.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct ResultView: View {
    let imagePath: String
    let results: [Any]
    let releaseYear: String
    let title: String
    let id: Int
    
    let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    var body: some View {
        List {
            ForEach(results, id: \.self) { result in
                NavigationLink(destination: DetailView().task { await task }) {
                    HStack(spacing: 20) {
                        // Potentially getting the image once in viewModel then passing it in.
                        AsyncImage(url: URL(string: imageBaseURL.appending(imagePath))) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(5)
                        } placeholder: {
                            placeholderImage()
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(title.capitalized)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(getDate(date: releaseYear, forYear: true))
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}


