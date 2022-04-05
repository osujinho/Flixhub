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
    }
}

struct FeaturedCrewView: View {
    let crews: [String : (id: Int, profile: String?, job: String)]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(crews.keys.sorted(), id: \.self) { key in
                if let value = crews[key] {
                    NavigationLink(destination:
                                    PersonDetailView(
                                        personID: String( value.id ),
                                        name: key,
                                        profile: value.profile
                                    )
                    ) {
                        CastProfileView(
                            name: key,
                            role: value.job,
                            profile: value.profile
                        )
                    }
                }
            }
        }
    }
}
