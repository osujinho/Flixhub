//
//  CastProfileView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct CastListView: View {
    @Binding var synopsisExpanded: Bool
    @Binding var creditsOption: CreditsOption
    let mainCrew: [Crew]
    let casts: [Cast]
    
    init(synopsisExpanded: Binding<Bool>, creditsOption: Binding<CreditsOption>, mainCrew: [Crew], casts: [Cast]) {
        UIScrollView.appearance().backgroundColor = UIColor(named: "background")
        self._synopsisExpanded = synopsisExpanded
        self._creditsOption = creditsOption
        self.mainCrew = mainCrew
        self.casts = casts
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom) {
                Text("Cast")
                    .movieFont(style: .bold, size: stackHeaderSize)
                    .padding(.horizontal, 10)
                    .foregroundColor(.primary)
                
                if synopsisExpanded {
                    Button(action: {
                        withAnimation {
                            synopsisExpanded = false
                        }
                    }) {
                        Image("chevronup")
                            .resizable()
                            .scaledToFit()
                    }
                }
                Spacer()
            }
            
            if !synopsisExpanded {
                VStack {
                    EnumPickerView("Credits", selection: $creditsOption)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .bottom, spacing: 10) {
                            
                            switch creditsOption {
                            case .casts:
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
                                            movieRole: cast.character,
                                            profile: cast.picture
                                        )
                                    }
                                }
                                .padding(.leading, 10)
                            case .crews:
                                ForEach(mainCrew, id: \.self) { director in
                                    NavigationLink(destination:
                                                    PersonDetailView(
                                                        personID: String ( director.id ),
                                                        name: director.name,
                                                        profile: director.profile_path
                                                    )
                                    ) {
                                        CastProfileView(
                                            name: director.name,
                                            movieRole: director.job,
                                            profile: director.profile_path
                                        )
                                    }
                                }
                                .padding(.leading, 10)
                            }
                            
                        } /// End of HStack
                    } /// End of ScrollView
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                }
            }
        }
    }
}


