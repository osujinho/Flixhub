//
//  PersonDetailView.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct PersonDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = PersonDetailViewModel()
    
    let personID: String
    let name: String
    let profile: String?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
            
            if viewModel.isLoading {
                LoadingView(
                    heading: "Loading details about \(name)",
                    poster: profile
                )
                    .transition(.scale)
            } else {
                VStack { /// Mother Stack
                    VStack(alignment: .leading) { /// Information stack
                            
                        PersonBioView(
                            profile: profile,
                            name: name,
                            personDetail: viewModel.personDetail
                        )
                        
                        SynopsisOrBiographyView(
                            isExpanded: $viewModel.biographyIsExpanded,
                            synopsis: viewModel.personDetail.biography,
                            label: "Biography"
                        )
                        
                    } /// End of information stack
                    .padding()
                    .padding(.top, 70)
                    
                    VStack { /// For the list
                        if viewModel.biographyIsExpanded { /// To toggle and close biography
                            Button(action: {
                                withAnimation {
                                    viewModel.biographyIsExpanded = false
                                }
                            }) {
                                Image("chevronup")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                        }
                        
                        EnumPickerView("Credits", selection: $viewModel.personCreditsOption)
                        
                        List {
                            switch viewModel.personCreditsOption {
                            case .castMovies:
                                ForEach(viewModel.castMovies, id: \.0.id) { movie in
                                    NavigationLink(destination:
                                                    MovieDetailView(
                                                        movieID: String( movie.0.id ),
                                                        movieTitle: movie.1.title,
                                                        imagePath: movie.0.poster
                                                    )
                                    ) {
                                        PersonMediaRowView(
                                            poster: movie.0.poster,
                                            mediaType: .castMovies,
                                            titleOrName: movie.1.title,
                                            date: movie.1.releaseDate,
                                            charcterOrJob: movie.0.character
                                        )
                                    }
                                }
                                
                            case .castShows:
                                ForEach(viewModel.castShows, id: \.0.id) { show in
                                    NavigationLink(destination:
                                                    ShowDetailView(
                                                        showId: String( show.0.id ),
                                                        showName: show.1.name,
                                                        imagePath: show.0.poster
                                                    )
                                    ) {
                                        PersonMediaRowView(
                                            poster: show.0.poster,
                                            mediaType: .castShows,
                                            titleOrName: show.1.name,
                                            date: show.1.airDate,
                                            charcterOrJob: show.0.character
                                        )
                                    }
                                }
                                
                            case .crewMovies:
                                ForEach(viewModel.crewMovies, id: \.0.id) { movie in
                                    NavigationLink(destination:
                                                    MovieDetailView(
                                                        movieID: String( movie.0.id ),
                                                        movieTitle: movie.1.title,
                                                        imagePath: movie.0.poster
                                                    )
                                    ) {
                                        PersonMediaRowView(
                                            poster: movie.0.poster,
                                            mediaType: .crewMovies,
                                            titleOrName: movie.1.title,
                                            date: movie.1.releaseDate,
                                            charcterOrJob: movie.0.job
                                        )
                                    }
                                }
                                
                            case .crewShows:
                                ForEach(viewModel.crewShows, id: \.0.id) { show in
                                    NavigationLink(destination:
                                                    ShowDetailView(
                                                        showId: String( show.0.id ),
                                                        showName: show.1.name,
                                                        imagePath: show.0.poster
                                                    )
                                    ) {
                                        PersonMediaRowView(
                                            poster: show.0.poster,
                                            mediaType: .crewShows,
                                            titleOrName: show.1.name,
                                            date: show.1.airDate,
                                            charcterOrJob: show.0.job
                                        )
                                    }
                                }
                            }
                        }
                        .if(viewModel.biographyIsExpanded) { view in
                            view
                                .frame(height: biographyExpandedHeight)
                        }
                    } /// End of list stack
                    
                } /// End of mother stack
            }
        }
        .edgesIgnoringSafeArea(.top)
        .task {
            await viewModel.getDetail(castId: personID)
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
                title: Text("Error getting \(name) details"),
                message: Text(viewModel.errorMessage),
                primaryButton: .destructive(Text("Retry")) {
                    Task {
                        await viewModel.getDetail(castId: personID)
                    }
                },
                secondaryButton: .cancel() { presentationMode.wrappedValue.dismiss() }
            )
        }

    }
}
