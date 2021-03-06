//
//  PersonCastShowView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/26/22.
//

import SwiftUI

struct PersonCastShowView: View {
    @State private var showGridView = false
    let shows: [(commonData: CastForPerson.CommonData, showData: PersonShowData)]
    
    var body: some View {
        Group {
            if showGridView {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: .sectionHeaders) {
                        Section(header: GridViewToggle(showGridView: $showGridView)){
                            ForEach(shows, id: \.commonData.id) { show in
                                NavigationLink(destination:
                                                ShowDetailView(
                                                    showId: String( show.commonData.tmdbID ),
                                                    showName: show.showData.name,
                                                    imagePath: show.commonData.poster
                                                )
                                ) {
                                    PosterView(
                                        imagePath: show.commonData.poster,
                                        title: show.showData.name,
                                        rating: show.commonData.rating
                                    )
                                }
                            }
                        }
                    }
                }
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 5, pinnedViews: .sectionHeaders) {
                        Section(header: GridViewToggle(showGridView: $showGridView)) {
                            ForEach(shows, id: \.commonData.id) { show in
                                NavigationLink(destination:
                                                ShowDetailView(
                                                    showId: String( show.commonData.tmdbID ),
                                                    showName: show.showData.name,
                                                    imagePath: show.commonData.poster
                                                )
                                ) {
                                    PersonMediaRowView(
                                        poster: show.commonData.poster,
                                        mediaType: .castShows,
                                        titleOrName: show.showData.name,
                                        date: show.showData.airDate,
                                        charcterOrJob: show.commonData.character,
                                        rating: show.commonData.rating,
                                        genres: show.commonData.genres
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }/// end of group
        .padding(.horizontal)
    }
}
