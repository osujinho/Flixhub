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
    let profilePicture: String
    let buttonAction: Func
    
    var body: some View {
        VStack {
            Button(action: {
                buttonAction()
            }, label: {
                Image(profilePicture)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .clipShape(Capsule())
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
