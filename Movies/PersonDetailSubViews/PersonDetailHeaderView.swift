//
//  PersonBioView.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

// For the top header with the image
struct PersonDetailHeaderView: View {
    let detail: PersonDetail
    
    var body: some View {
        VStack {
            UrlImageView(path: detail.profile, defaultImage: .profile)
                .offset(y: 10)
                .frame(width: 150, height: 150, alignment: .center)
                .clipShape(Circle())
                .cornerRadius(10)
            Text(detail.name)
                .movieFont(style: .bold, size: personDetailNameSize)
            Text(detail.knownFor ?? "")
                .foregroundColor(.secondary)
            HStack {
                Text(getAge(birthDate: detail.birthday))
                Text("•")
                    .font(.system(size: 30))
                Text(getGender(genderNumber: detail.gender))
            }.movieFont(style: .regular, size: personDetailHeaderSize)
        }
        .movieFont(style: .regular, size: personDetailHeaderSize)
    }
}
