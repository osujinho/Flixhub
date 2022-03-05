//
//  AsyncImageView.swift
//  Movies
//
//  Created by Michael Osuji on 2/23/22.
//

import SwiftUI

struct AsyncImageView: View {
    let path: String?
    let forProfile: Bool
    
    init(path: String?, forProfile: Bool = false) {
        self.path = path
        self.forProfile = forProfile
    }
    
    var body: some View {
        AsyncImage(url: URL(string: getImageUrl(path)), transaction: Transaction(animation: .spring())) { phase in
            switch phase {
            case .empty:
                Image(systemName: forProfile ? "person.circle.fill" : "photo")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .overlay(
                        ProgressView()
                    )
         
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: forProfile ? .fit : .fill)
                    .if(forProfile) { view in
                        view
                            .frame(width: 120)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.blue, lineWidth: 2))
                            .shadow(radius: 4)
                            .padding(.horizontal, 8)
                    }
                    .transition(.slide)
         
            case .failure(_):
                Image(systemName: "person.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .overlay(
                        Image(systemName: "exclamationmark.icloud")
                            .font(.system(size: 25).bold())
                            .foregroundColor(Color.orange)
                    )
         
            @unknown default:
                Image(systemName: "person.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .overlay(
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 25).bold())
                            .foregroundColor(Color.red)
                    )
            }
        }
    }
}
