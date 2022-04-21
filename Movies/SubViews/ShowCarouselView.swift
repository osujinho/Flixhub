//
//  ShowCarouselView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/21/22.
//

import SwiftUI

struct ShowCarouselView: View {
    
    let categoryName: String
    let showType: MovieType
    let shows: [ShowResult]
    let totalPages: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(categoryName)
                    .movieFont(style: .bold, size: browseLabelSize)
                Spacer()
                
                NavigationLink(destination:
                                MoreShowView(
                                    header: categoryName,
                                    showType: showType,
                                    shows: shows,
                                    totalPages: totalPages
                                )
                ){
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10))
                }
                
            }.padding(.horizontal)
             
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .bottom, spacing: 5) {
                    ForEach(shows, id: \.self) { show in
                        NavigationLink( destination:
                                            ShowDetailView(
                                                showId: String ( show.id ),
                                                showName: show.name,
                                                imagePath: show.poster
                                            )
                        ) {
                            PosterView(
                                imagePath: show.poster,
                                title: show.name,
                                rating: show.rating
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
