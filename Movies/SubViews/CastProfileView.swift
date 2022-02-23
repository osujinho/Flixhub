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
    let imagePath: String?
    let buttonAction: Func
    
    var body: some View {
        VStack {
            Button(action: {
                // Call for async function
                buttonAction()
            }, label: {
                AsyncImageView(path: imagePath, forProfile: true)
                    .frame(width: 120)
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
