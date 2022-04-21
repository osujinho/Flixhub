//
//  MoreShowsView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/4/22.
//

import SwiftUI

struct MoreShowsView: View {
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
        
        UITableViewCell.appearance().backgroundColor = UIColor(named: "background")
        UITableView.appearance().backgroundColor = UIColor(named: "background")
    }
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            VStack {
                Group {
                    if viewModel.presentGridView {
                        ScrollView {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 5) {
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
                            }
                        }
                        .simultaneousGesture(
                            DragGesture( minimumDistance: viewModel.isLoading ? 0 : .infinity ),
                            including: .all
                        )
                        .transition(.move(edge: .bottom))
                        .padding(.horizontal, 10)
                    } else {
                        List {
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
                                .listRowBackground(Color.clear)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .transition(.move(edge: .bottom))
                    }
                }
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
                    Image(systemName: "chevron.left.circle.fill")
                        .renderingMode(.template)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary) /// Fix after implementing Both dark and light mode
                })
            }
            
            ToolbarItem(placement: .principal) {
                Text(header)
                    .movieFont(style: .bold, size: inlineNavSize)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        viewModel.presentGridView.toggle()
                    }
                }, label: {
                    Image(systemName: viewModel.presentGridView ? "list.bullet.circle.fill" : "circle.grid.3x3.circle.fill")
                        .renderingMode(.template)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary) /// Fix after implementing Both dark and light mode
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
