//
//  CreditsProfileView.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct CastProfileView: View {
    let name: String
    let movieRole: String
    let profile: String?
    
    var body: some View {
        VStack(spacing: 0) {
            UrlImageView(path: profile, defaultImage: .profile)
                .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle()
                            .stroke(Color.blue, lineWidth: 2))
                .shadow(radius: 4)
                .padding(.horizontal, 8)
                .padding(.bottom, 10)
            
            VStack(spacing: 0) {
                // Name
                Text(name)
                    .movieFont(style: .label)
                    .foregroundColor(.white)
                    .lineLimit(nil)
                    .padding(.bottom, 1)
                
                // Movie Role
                Text(movieRole)
                    .movieFont(style: .petite)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(nil)
            }
        }
        .scaledToFit()
        .padding(.top, 3)
        .padding(.bottom, 10)
        .padding(.trailing, 10)
    }
}
