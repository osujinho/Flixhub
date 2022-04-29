//
//  PersonRowView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/29/22.
//

import SwiftUI

struct PersonRowView: View {
    let name: String
    let gender: Int?
    let department: String?
    let profile: String?
    let posterWidth: CGFloat = 100
    
    var body: some View {
        HStack(spacing: 20) {
            UrlImageView(path: profile, defaultImage: .profile)
                .frame(maxWidth: posterWidth, maxHeight: posterWidth, alignment: .center)
                .offset(y: 10)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                // Name
                Text(name)
                    .multilineTextAlignment(.leading)
                    .movieFont(style: .bold, size: listRowTitleSize)
                    .foregroundColor(.primary)
                
                // Gender
                Text(getGender(genderNumber: gender))
                    .movieFont(style: .regular, size: bodySize)
                    .foregroundColor(.secondary)
                
                // Known for
                if let department = department {
                    HStack {
                        Text("Known For")
                            .foregroundColor(.secondary)
                        Text(department)
                            .foregroundColor(.primary)
                    }
                    .movieFont(style: .regular, size: bodySize)
                }
            }
            Spacer()
        }
    }
}
