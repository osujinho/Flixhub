//
//  DetailView.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: MoviesViewModel
    @State private var isExpanded: Bool = false
    
    private let detail: TMDBDetail
    private let fullDetail: OMDBDetail
    private let castDetail: CastDetail
    private let isUpcoming: Bool
    
    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.black.opacity(0.7), location: 0),
            .init(color: .clear, location: 0.4)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        VStack {
            // top With Image and info
            Image(detail.poster)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .aspectRatio(contentMode: .fill)
            // Radial gradient Overlay
                .overlay(
                    ZStack(alignment: .bottom) {
                        Image(detail.poster)
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .blur(radius: 20)
                            .padding(-20)
                            .clipped()
                            .mask(gradient)
                        
                        gradient
                        
                        VStack {
                            // Top part
                            HStack {
                                HStack(spacing: 20) {
                                    Button(
                                        action: { self.presentationMode.wrappedValue.dismiss()
                                            
                                        }, label: {
                                            Image(systemName: "chevron.left.circle.fill")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 30))
                                        }
                                    )
                                    
                                    Text(fullDetail.rating)
                                        .circleTextViewModifier()
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 20) {
                                    Text(fullDetail.rated)
                                        .squareTextViewModifier()
                                    
                                    // Heart for Favorite
                                    Button(
                                        action: {
                                            // Todo
                                        }, label: {
                                            Image(systemName: "suit.heart.fill")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 35))
                                        }
                                    )
                                }
                            }
                            
                            Spacer()
                            
                            // Bottom part
                            HStack {
                                VStack(alignment: .leading) {
                                    // runtime and release date (if upcoming)
                                    Text(detail.title.uppercased())
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(.white)
                                        //.padding(.bottom, 2)
                                    
                                    HStack(spacing: 30) {
                                        Text(stringToTime(strTime: detail.releaseDate))
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(.white.opacity(0.7))
                                        Text(isUpcoming ?
                                             getDate(date: detail.releaseDate, forYear: false) :
                                                getDate(date: detail.releaseDate, forYear: true))
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    .padding(.bottom, 10)
                                    
                                    HStack(alignment: .lastTextBaseline) {
                                        ForEach(detail.genre, id:\.self) { genre in
                                            Text(genre.name.capitalized)
                                                .genreTextViewModifier()
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 70)
                        .padding(.bottom, 5)
                    }
                )
                .edgesIgnoringSafeArea(.top)
            
            // Plot
            VStack(alignment: .leading) {
                Text("Synopsis")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 5)
                Text(detail.plot)
                    .font(.subheadline)
                    .lineLimit(isExpanded ? nil : 2)
                    .padding(.bottom, 8)
                Button(action: {
                    isExpanded.toggle()
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                // design plot with more which will increase
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            
            // The cast members
            VStack(alignment: .leading, spacing: 10) {
                Text("Cast")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.getDirectors(castDetail: castDetail), id: \.self) { director in
                            CastProfileView(name: director.name, movieRole: director.job, profilePicture: director.profile_path, buttonAction: { })
                        }
                        
                        ForEach(castDetail.cast, id: \.self) { cast in
                            CastProfileView(name: cast.name, movieRole: cast.character, profilePicture: cast.picture, buttonAction: { })
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .background(Color.gray.opacity(0.1))
            .padding(.bottom, 30)
            .edgesIgnoringSafeArea(.bottom)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Movie Detail Error"),
                message: Text(viewModel.errorMessage),
                primaryButton: .destructive(Text("Retry")) {
                    // Use Task to run async method
                },
                secondaryButton: .cancel()  // add a way to dismiss view and go back
            )
        }
    }
}
