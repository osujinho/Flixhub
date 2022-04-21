//
//  RecommendAndSimilarShowView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/4/22.
//

import SwiftUI

struct RecommendAndSimilarShowView: View {
    @StateObject var viewModel: MoreShowsViewModel
    
    let showType: MovieType
    let totalPages: Int
    let shows: [ShowResult]
    
    var body: some View {
        Group {
            if viewModel.presentGridView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: .sectionHeaders) {
                    Section(header: GridViewToggle(showGridView: $viewModel.presentGridView)) {
                        ForEach(viewModel.shows, id: \.self) { show in
                            NavigationLink(destination:
                                            ShowDetailView(
                                                showId: String( show.id ),
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
                            .task {
                                viewModel.currentShow = show
                                await viewModel.loadMoreShowIfNeeded(currentShow: show)
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .simultaneousGesture(
                    DragGesture(
                        minimumDistance: viewModel.isLoading ? 0 : .infinity),
                    including: .all
                )
                .transition(.move(edge: .bottom))
                .padding(.horizontal, 10)
            } else {
                LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                    Section(header: GridViewToggle(showGridView: $viewModel.presentGridView)) {
                        ForEach(viewModel.shows, id: \.self) { show in
                            NavigationLink(destination:
                                            ShowDetailView(
                                                showId: String( show.id ),
                                                showName: show.name,
                                                imagePath: show.poster
                                            )
                            ) {
                                MoreShowRowView(show: show)
                            }
                            .task {
                                viewModel.currentShow = show
                                await viewModel.loadMoreShowIfNeeded(currentShow: show)
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
        .onAppear{
            viewModel.shows = shows
            viewModel.totalPages = totalPages
            viewModel.showType = showType
        }
    }
}
