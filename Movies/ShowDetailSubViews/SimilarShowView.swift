//
//  SimilarShowView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/20/22.
//

import SwiftUI

struct SimilarShowView: View {
    @StateObject private var viewModel: SimilarShowViewModel
    let totalPages: Int
    let results: [ShowResult]
    let showID: String
    
    init(totalPages: Int, results: [ShowResult], showID: String) {
        self._viewModel = StateObject(wrappedValue: SimilarShowViewModel())
        self.totalPages = totalPages
        self.results = results
        self.showID = showID
    }
    
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
        .padding(.bottom)
        .onAppear{
            viewModel.shows = results
            viewModel.totalPages = totalPages
            viewModel.showID = showID
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Error Loading more movies"),
                message: Text(viewModel.errorMessage),
                dismissButton: .destructive(Text("Retry")) {
                    Task {
                        await viewModel.loadMoreShowIfNeeded(currentShow: viewModel.currentShow)
                    }
                }
            )
        }
    }
}
