//
//  PersonDetailView.swift
//  Movies
//
//  Created by Michael Osuji on 3/14/22.
//

import SwiftUI

struct PersonDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: PersonDetailViewModel
    
    let personID: String
    let name: String
    let profile: String?
    
    init(personID: String, name: String, profile: String?) {
        self._viewModel = StateObject(wrappedValue: PersonDetailViewModel())
        self.personID = personID
        self.name = name
        self.profile = profile
        
        UITableViewCell.appearance().backgroundColor = UIColor(named: "background")
        UITableView.appearance().backgroundColor = UIColor(named: "background")
    }
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoading {
                LoadingView(
                    heading: "Loading details about \(name)",
                    poster: profile
                )
                    .transition(.scale)
            } else {
                GeometryReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                            PersonDetailHeaderView(detail: viewModel.personDetail)
                                .background(Color("tabColor"))
                                .padding(.top, -proxy.safeAreaInsets.top)
                            
                            Section(header:
                                        CustomPickerView(selection: $viewModel.personDetailOption, backgroundColor: "tabColor")
                                            .padding(.bottom)
                            ) {
                                
                                switch viewModel.personDetailOption {
                                case .about:
                                    PersonAboutView(detail: viewModel.personDetail, taggedImages: viewModel.taggedImages)
                                case .movies:
                                    PersonCastMovieView(movies: viewModel.castMovies)
                                case .shows:
                                    PersonCastShowView(shows: viewModel.castShows)
                                case .crewMovies:
                                    PersonCrewMovieView(movies: viewModel.crewMovies)
                                case .crewShows:
                                    PersonCrewShowView(shows: viewModel.crewShows)
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(Color("background"))
        .task {
            await viewModel.getDetail(castId: personID)
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
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
