//
//  ShowDetailView.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct ShowDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: ShowDetailViewModel
    
    let showId: String
    let showName: String
    let imagePath: String?
    
    init(showId: String, showName: String, imagePath: String?) {
        self._viewModel = StateObject(wrappedValue: ShowDetailViewModel())
        self.showId = showId
        self.showName = showName
        self.imagePath = imagePath
    }
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            Group {
                if viewModel.isLoading {
                    LoadingView(
                        heading: "Loading details on \(showName)",
                        poster: imagePath
                    )
                    .transition(.scale)
                } else {
                    GeometryReader { proxy in
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                                // Top View
                                ShowDetailHeaderView(
                                    detail: viewModel.showDetail,
                                    topPaddingSize: proxy.safeAreaInsets.top
                                )
                                .background(Color("tabColor"))
                                
                                // Sticky header
                                Section(header:
                                            CustomPickerView(
                                                selection: $viewModel.showDetailOption,
                                                backgroundColor: "tabColor"
                                            )
                                ) {
                                    switch viewModel.showDetailOption {
                                    case .about:
                                        ShowAboutView(
                                            detail: viewModel.showDetail,
                                            rated: viewModel.rated,
                                            runtime: viewModel.runtimes,
                                            spokenLanguage: viewModel.spokenLanguages,
                                            inProduction: viewModel.inProduction
                                        )
                                    case .casts:
                                        CastView(casts: viewModel.showDetail.credits.cast)
                                    case .crew:
                                        FeaturedCrewView(crews: viewModel.mainCrew)
                                    case .media:
                                        MediaScrollView(
                                            posters: viewModel.showDetail.images.posters.map{ $0.path },
                                            videos: viewModel.showDetail.videos.results,
                                            backdrops: viewModel.showDetail.images.backdrops.map{ $0.path })
                                    case .seasons:
                                        ShowSeasonsView(seasons: viewModel.showDetail.seasons)
                                    case .recommended:
                                        RecommendAndSimilarShowView(
                                            viewModel: MoreShowsViewModel(),
                                            showType: .recommendShow,
                                            totalPages: viewModel.recommendShows.total_pages,
                                            shows: viewModel.recommendShows.results
                                        )
                                    case .similar:
                                        RecommendAndSimilarShowView(
                                            viewModel: MoreShowsViewModel(),
                                            showType: .similarShow,
                                            totalPages: viewModel.similarShows.total_pages,
                                            shows: viewModel.similarShows.results
                                        )
                                        
                                    }
                                }
                                .frame(alignment: .leading)
                            }
                        }
                        .transition(.slide)
                    } /// End of geometry reader
                } /// End of else block
            } /// End og group
        } /// End of ZStack
        .background(Color("background"))
        .task {
            await viewModel.getShowDetail(id: showId)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .renderingMode(.original)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black) /// Fix after implementing Both dark and light mode
                })
            }
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("TV-Show Detail Error"),
                message: Text(viewModel.errorMessage),
                primaryButton: .destructive(Text("Retry")) {
                    Task { await viewModel.getShowDetail(id: showId) }
                },
                secondaryButton: .cancel() {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

