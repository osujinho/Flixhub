//
//  CastProfileView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct CastListView: View {
    let directors: [Crew]
    let casts: [Cast]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Cast")
                    .movieFont(size: 23)
                    .padding(.horizontal, 10)
                    .foregroundColor(.white)
                
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 10) {
                    /// Put them in a navigationLink to search movies about cast member
                    HStack {
                        ForEach(directors, id: \.self) { director in
                            NavigationLink(destination:
                                            FetchCastMovieView(
                                                castName: director.name,
                                                forDirector: true,
                                                type: .browseDirector,
                                                castID: String( director.id ),
                                                profile: director.profile_path
                                            )
                            ) {
                                CastProfileView(
                                    name: director.name,
                                    movieRole: director.job,
                                    profile: director.profile_path
                                )
                            }
                        }
                        .padding(.leading, 10)
                        
                        ForEach(casts, id: \.self) { cast in
                            NavigationLink(destination:
                                            FetchCastMovieView(
                                                castName: cast.name,
                                                forDirector: false,
                                                type: .browseActor,
                                                castID: String( cast.castID ),
                                                profile: cast.picture)
                            ) {
                                CastProfileView(
                                    name: cast.name,
                                    movieRole: cast.character,
                                    profile: cast.picture
                                )
                            }
                        }
                    }
                } /// End of HStack
            } /// End of ScrollView
            .padding(.horizontal, 10)
            .padding(.top, 10)
        }
    }
}

struct CastProfileView: View {
    let name: String
    let movieRole: String
    let profile: String?
    
    var body: some View {
        VStack(spacing: 0) {
            UrlImageView(path: profile, defaultImage: .profile)
                
                .frame(maxWidth: 100, maxHeight: 100, alignment: .top)
                .clipShape(Circle())
                .overlay(Circle()
                            .stroke(Color.blue, lineWidth: 2))
                .shadow(radius: 4)
                .padding(.horizontal, 8)
                .padding(.bottom, 10)
            
            VStack(spacing: 0) {
                // Name
                Text(name)
                    .movieFont(size: 13)
                    .foregroundColor(.white)
                    .lineLimit(nil)
                    .padding(.bottom, 1)
                
                // Movie Role
                Text(movieRole)
                    .movieFont(size: 10)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(nil)
            }
        }
        .scaledToFit()
        .padding(.top, 3)
        .padding(.bottom, 10)
        .padding(.trailing, 10)
    }
}
