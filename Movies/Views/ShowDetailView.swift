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
            
            GeometryReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                        // Top View
                        ShowDetailHeaderView(
                            playTrailer: $viewModel.playTrailer,
                            detail: viewModel.showDetail,
                            topPaddingSize: proxy.safeAreaInsets.top,
                            rated: viewModel.rated,
                            noTrailerAlertOpacity: viewModel.noTrailerAlertOpacity,
                            trailerID: viewModel.trailerID,
                            checkForTrailer: viewModel.checkForTrailer
                        )
                        
                        // Sticky header
                        Section(header:
                                    CustomPickerView(
                                        selection: $viewModel.showDetailOption,
                                        backgroundColor: "pickerColor"
                                    )
                                    .padding(.bottom)
                        ) {
                            switch viewModel.showDetailOption {
                            case .about:
                                ShowAboutView(
                                    detail: viewModel.showDetail,
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
                                    videos: viewModel.videoClips,
                                    backdrops: viewModel.showDetail.images.backdrops.map{ $0.path })
                            case .seasons:
                                ShowSeasonsView(seasons: viewModel.showDetail.seasons)
                            case .recommended:
                                RecommendShowView(
                                    totalPages: viewModel.recommendShows.total_pages,
                                    results: viewModel.recommendShows.results,
                                    showID: showId
                                )
                            case .similar:
                                SimilarShowView(
                                    totalPages: viewModel.similarShows.total_pages,
                                    results: viewModel.similarShows.results,
                                    showID: showId
                                )
                            }
                        }
                        .frame(alignment: .leading)
                    }
                }
            } /// End of geometry reader
            .transition(.slide)
        } /// End of ZStack
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

