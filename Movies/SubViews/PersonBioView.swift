//
//  PersonBioView.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct PersonBioView: View {
    let profile: String?
    let name: String
    let personDetail: PersonDetail
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) { /// Display heading including profile picture
            NavigationLink(destination:
                            MovieGallery(
                                images: personDetail.images.profiles,
                                isPoster: true)
            ){
                UrlImageView(path: profile, defaultImage: .profile)
                    .frame(width: personDetailProfilePictureSize.width, height: personDetailProfilePictureSize.height)
                    .cornerRadius(5)
                
            }
            
            VStack(alignment: .leading, spacing: 5) {  /// Information stack
                HStack { /// For the name
                    Text(name.uppercased())
                        .movieFont(style: .name)
                }
                
                HStack(alignment: .bottom, spacing: 10) { /// For Birth place
                    Text("Birthplace:")
                        .movieFont(style: .label)
                    
                    Text(personDetail.birthPlace ?? "N/A")
                }
                
                HStack(alignment: .bottom, spacing: 38) { /// For what they are known for and gender
                    Text("Gender:")
                        .movieFont(style: .label)
                    Text(getGender(genderNumber: personDetail.gender))
                }
                HStack(alignment: .bottom, spacing: 13) {
                    Text("Known For:")
                        .movieFont(style: .label)
                    Text(personDetail.knownFor ?? "N/A")
                }
                
                let deathdate = getDeathdate(date: personDetail.deathday)
                
                HStack(alignment: .bottom, spacing: 10) {  /// For dates
                    Text("Born:")
                        .movieFont(style: .label)
                    Text(getDate(date: personDetail.birthday ,forYear: false))
                    
                    Spacer()
                    
                    if deathdate.lowercased() == "alive" {
                        HStack(alignment: .bottom) {
                            Text("Died:")
                                .movieFont(style: .label)
                            Text(deathdate)
                                .foregroundColor(.green.opacity(0.8))
                        }
                    }
                }
                if deathdate.lowercased() != "alive" {
                    HStack(alignment: .bottom, spacing: 10) {
                        Text("Died:")
                            .movieFont(style: .label)
                        Text(deathdate)
                            .foregroundColor(.red.opacity(0.8))
                    }
                }
            } /// End of information vstack
            .movieFont(style: .body)
            
            Spacer()  /// To push everything to align the correct way
        } /// end of mother Hstack
    }
}
