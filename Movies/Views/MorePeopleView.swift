//
//  MorePeopleView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/29/22.
//

import SwiftUI

struct MorePeopleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: MorePeopleViewModel
    
    let movieType: MovieType
    let people: [PersonResult]
    let totalPages: Int
    let header: String
    
    init(movieType: MovieType, people: [PersonResult], totalPages: Int, header: String) {
        self._viewModel = StateObject(wrappedValue: MorePeopleViewModel())
        self.movieType = movieType
        self.people = people
        self.totalPages = totalPages
        self.header = header
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
                                    ForEach(viewModel.people, id: \.self){ person in
                                        NavigationLink(destination:
                                                        PersonDetailView(
                                                            personID: String( person.id ),
                                                            name: person.name,
                                                            profile: person.profile
                                                        )
                                        ) {
                                            PersonPosterView(
                                                name: person.name,
                                                imagePath: person.profile,
                                                gender: person.gender,
                                                department: person.department
                                            )
                                        }
                                        .task {
                                            viewModel.currentPerson = person
                                            await viewModel.loadMoreMovieIfNeeded(currentPerson: person)
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
                                    ForEach(viewModel.people, id: \.self){ person in
                                        NavigationLink(destination:
                                                        PersonDetailView(
                                                            personID: String( person.id ),
                                                            name: person.name,
                                                            profile: person.profile
                                                        )
                                        ) {
                                            PersonRowView(
                                                name: person.name,
                                                gender: person.gender,
                                                department: person.department,
                                                profile: person.profile
                                            )
                                        }
                                        .task {
                                            viewModel.currentPerson = person
                                            await viewModel.loadMoreMovieIfNeeded(currentPerson: person)
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
            viewModel.people = people
            viewModel.totalPages = totalPages
            viewModel.searchType = movieType
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
                title: Text("Error Loading more people"),
                message: Text(viewModel.errorMessage),
                dismissButton: .destructive(Text("Retry")) {
                    Task {
                        await viewModel.loadMoreMovieIfNeeded(currentPerson: viewModel.currentPerson)
                    }
                }
            )
        }
    }
}
