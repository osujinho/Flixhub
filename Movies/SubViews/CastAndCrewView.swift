//
//  CastAndCrewView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/31/22.
//

import SwiftUI

struct CastView: View {
    let casts: [Cast]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(casts, id: \.self) { cast in
                NavigationLink(destination:
                                PersonDetailView(
                                    personID: String( cast.castID ),
                                    name: cast.name,
                                    profile: cast.picture
                                )
                ) {
                    CastProfileView(
                        name: cast.name,
                        role: cast.character,
                        profile: cast.picture
                    )
                }
            }
        }
        .padding(.bottom)
    }
}

struct FeaturedCrewView: View {
    let crews: [Int: MainCrew]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(crews.keys.sorted(), id: \.self) { key in
                if let value = crews[key] {
                    NavigationLink(destination:
                                    PersonDetailView(
                                        personID: String( key ),
                                        name: value.name,
                                        profile: value.profile
                                    )
                    ) {
                        CastProfileView(
                            name: value.name,
                            role: value.job,
                            profile: value.profile
                        )
                    }
                }
            }
        }
       .padding(.bottom)
    }
}
