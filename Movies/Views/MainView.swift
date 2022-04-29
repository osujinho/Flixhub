//
//  MainView.swift
//  Movies
//
//  Created by Michael Osuji on 3/10/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var browseMoviesViewModel: BrowseViewModel
    @StateObject private var showBrowseViewModel: ShowBrowseViewModel
    @StateObject private var trendingViewModel: TrendingViewModel
    @EnvironmentObject var appViewModel: AppViewModel
    @State var selectedTab: Tab = .trending
    var edges = UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.safeAreaInsets
    @Namespace var animation
    
    init() {
        self._browseMoviesViewModel = StateObject(wrappedValue: BrowseViewModel())
        self._showBrowseViewModel = StateObject(wrappedValue: ShowBrowseViewModel())
        self._trendingViewModel = StateObject(wrappedValue: TrendingViewModel())
    }
    
    var body: some View {
        
        VStack {
            if trendingViewModel.isLoading {
                SpashView()
            } else {
                GeometryReader { _ in
                    ZStack {
                        TrendingView(viewModel: trendingViewModel)
                            .opacity(selectedTab == .trending ? 1 : 0)
                        
                        BrowseView(viewModel: browseMoviesViewModel)
                            .opacity(selectedTab == .movies ? 1 : 0)
                        
                        ShowBrowseView(viewModel: showBrowseViewModel)
                            .opacity(selectedTab == .shows ? 1 : 0)
                        
                        SearchView()
                            .opacity(selectedTab == .search ? 1 : 0)
                    } /// End of ZStack
                } /// end of Geometry reader
                .onChange(of: selectedTab) { newTab in
                    switch selectedTab {
                    case .movies:
                        Task { await browseMoviesViewModel.fetchMovies() }
                    case .shows:
                        Task { await showBrowseViewModel.fetchShows() }
                    default: ()
                    }
                }
                
                if !appViewModel.showFullImageView {
                    HStack(spacing: 0){
                        
                        ForEach(Tab.allCases) {tab in
                            
                            TabButtonView(tab: tab, selectedTab: $selectedTab, animation: animation)
                            
                            if tab != .search {
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding(.horizontal,30)
                    // for iphone like 8 and SE
                    .padding(.bottom,edges!.bottom == 0 ? 15 : edges!.bottom)
                    .background(Color("tabColor"))
                }
            } /// End of else block
        } /// End of Mother VStack
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color("background").ignoresSafeArea(.all, edges: .all))
        .task {
            await trendingViewModel.fetchTrending()
        }
        .alert(isPresented: $trendingViewModel.hasError) {
            Alert(
                title: Text("Error Loading Movies"),
                message: Text(trendingViewModel.errorMessage),
                dismissButton: .destructive(Text("Retry")) {
                    Task {
                        await trendingViewModel.fetchTrending()
                    }
                }
            )
        }
    }
}
