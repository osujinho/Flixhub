//
//  PeopleCarouselView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/29/22.
//

import SwiftUI

struct PeopleCarouselView: View {
    let categoryName: String
    let type: MovieType
    let people: [PersonResult]
    let totalPages: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(categoryName)
                    .movieFont(style: .bold, size: browseLabelSize)
                Spacer()
                
                NavigationLink(destination:
                                MorePeopleView(
                                    movieType: type,
                                    people: people,
                                    totalPages: totalPages,
                                    header: categoryName
                                )
                ){
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10))
                }
                
            }.padding(.horizontal)
             
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .bottom, spacing: 5) {
                    ForEach(people, id: \.self) { person in
                        NavigationLink( destination:
                                            PersonDetailView(
                                                personID: String( person.id ),
                                                name: person.name,
                                                profile: person.profile
                                            )
                        ) {
                            PersonPosterView(
                                name: person.name,
                                imagePath: person.profile,
                                gender: person.gender,
                                department: person.department
                            )
                        }
                    } //End ForEach
                    
                } //End HStack
                .padding(.leading, 10)
            }// End ScrollView
        }//End VStack
        .padding(.bottom)
    }
}
