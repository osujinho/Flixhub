//
//  MainView.swift
//  Movies
//
//  Created by Michael Osuji on 3/10/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: BrowseViewModel
    @State var selectedTab: Tab = .movies
    var edges = UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.safeAreaInsets
    @Namespace var animation
    
    init() {
        self._viewModel = StateObject(wrappedValue: BrowseViewModel())
    }
    
    var body: some View {
        
        VStack {
            if viewModel.isLoading {
                SpashView()
            } else {
                GeometryReader { _ in
                    ZStack {
                        BrowseView(viewModel: viewModel)
                            .opacity(selectedTab == .movies ? 1 : 0)
                        
                        SearchView()
                            .opacity(selectedTab == .search ? 1 : 0)
                    } /// End of ZStack
                } /// end of Geometry reader
                
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
            } /// End of else block
        } /// End of Mother VStack
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color("background").ignoresSafeArea(.all, edges: .all))
        .task {
            await viewModel.fetchMovies()
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Error Loading Movies"),
                message: Text(viewModel.errorMessage),
                dismissButton: .destructive(Text("Retry")) {
                    Task {
                        await viewModel.fetchMovies()
                    }
                }
            )
        }
    }
}
