//
//  CreditsProfileView.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct CastProfileView: View {
    let name: String
    let role: String
    let profile: String?
    
    var body: some View {
        HStack(spacing: 20) {
            UrlImageView(path: profile, defaultImage: .profile)
                .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
                .offset(y: 10)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                // Name
                Text(name)
                    .movieFont(style: .regular, size: labelSize)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                
                // Movie Role
                Text(role)
                    .movieFont(style: .regular, size: bodySize)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
