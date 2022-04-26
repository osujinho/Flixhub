//
//  MoreShowView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/21/22.
//

import SwiftUI

struct MoreShowView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: MoreShowsViewModel
    
    let header: String
    let showType: MovieType
    let shows: [ShowResult]
    let totalPages: Int
    
    init(header: String, showType: MovieType, shows: [ShowResult], totalPages: Int) {
        self._viewModel = StateObject(wrappedValue: MoreShowsViewModel())
        self.header = header
        self.showType = showType
        self.shows = shows
        self.totalPages = totalPages
    }
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            VStack {
                Group {
                    if viewModel.presentGridView {
                        ScrollView {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 5, pinnedViews: .sectionHeaders) {
                                Section(header:
                                            GridViewToggle(showGridView: $viewModel.presentGridView)
                                    .padding(.bottom)
                                ) {
                                    ForEach(viewModel.shows, id: \.self){ show in
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
                                    } /// End of ForEach
                                } /// End of section
                            } /// End of VGrid
                            
                        } /// End of scrollView
                        .simultaneousGesture(
                            DragGesture( minimumDistance: viewModel.isLoading ? 0 : .infinity ),
                            including: .all
                        )
                        .transition(.move(edge: .bottom))
                        .padding(.horizontal, 10)
                    } else {
                        
                        ScrollView {
                            LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                                Section(header:
                                            GridViewToggle(showGridView: $viewModel.presentGridView)
                                    .padding(.bottom)
                                ) {
                                    ForEach(viewModel.shows, id: \.self){ show in
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
                                    } /// End of ForEach
                                    
                                } /// End of section
                            } /// End of lazyVStack
                        } /// End of scrollView
                        .transition(.move(edge: .bottom))
                        .padding(.horizontal, 10)
                    }
                } /// end of group
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            viewModel.shows = shows
            viewModel.totalPages = totalPages
            viewModel.showType = showType
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack(spacing: 10) {
                        Image(systemName: "chevron.left.circle.fill")
                            .renderingMode(.template)
                            .font(.system(size: 20, weight: .bold))
                        
                        Text(header)
                            .movieFont(style: .bold, size: inlineNavSize)
                    }
                    .foregroundColor(.primary)
                })
            }
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
