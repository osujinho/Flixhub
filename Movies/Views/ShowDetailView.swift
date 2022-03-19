//
//  ShowDetailView.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct ShowDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = ShowDetailViewModel()
    
    let showId: String
    let showName: String
    let imagePath: String?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
            
            Group {
                if viewModel.isLoading {
                    LoadingView(
                        heading: "Loading details on \(showName)",
                        poster: imagePath
                    )
                        .transition(.scale)
                } else {
                    VStack(spacing: 0) {
                        TrailerPlayer(
                            playTrailer: $viewModel.playTrailer,
                            synopsisExpanded: $viewModel.synopsisExpanded,
                            videoID: viewModel.youtubeKey,
                            backdrop: viewModel.showDetail.backdrop
                        )
                        .scaledToFit()
                        
                        VStack {
                            ShowInfo(
                                playTrailer: $viewModel.playTrailer,
                                synopsisExpanded: $viewModel.synopsisExpanded,
                                showDetail: viewModel.showDetail,
                                gridCollections: viewModel.gridCollections
                            )
                            
                            SynopsisOrBiographyView(
                                isExpanded: $viewModel.synopsisExpanded,
                                synopsis: viewModel.showDetail.synopsis,
                                label: "Synopsis"
                            )
                            
                            CastListView(
                                synopsisExpanded: $viewModel.synopsisExpanded,
                                creditsOption: $viewModel.creditsOption,
                                mainCrew: viewModel.mainCrew,
                                casts: viewModel.showDetail.credits.cast
                            )
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        
                        Spacer()
                    }
                    .transition(.slide)
                } /// End of else block
            } /// End og group
        } /// End of ZStack
        .edgesIgnoringSafeArea(.top)
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
