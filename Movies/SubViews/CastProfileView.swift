//
//  CastProfileView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct CastProfileView: View {
    let name: String
    let movieRole: String
    let imagePath: String
    let buttonAction: Func
    
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    var body: some View {
        VStack {
            Button(action: {
                buttonAction()
            }, label: {
                AsyncImage(url: URL(string: imageBaseUrl.appending(imagePath))) { image in
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .clipShape(Capsule())
                } placeholder: {
                    placeholderImage()
                }
            })
            
            // Name
            Text(name)
                .font(.subheadline)
            
            // Movie Role
            Text(movieRole)
                .font(.caption)
                .foregroundColor(.black.opacity(0.7))
        }
        .padding(.bottom, 20)
    }
}
