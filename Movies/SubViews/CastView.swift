//
//  CastProfileView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct CastView: View {
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
            
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        /// Put them in a navigationLink to search movies about cast member
                        ForEach(directors, id: \.self) { director in
                            NavigationLink(destination:
                                            CastMovieView(
                                                castName: director.name,
                                                forDirector: true,
                                                type: .browseDirector,
                                                castID: String( director.id ),
                                                imagePath: director.profile_path
                                            )
                            ) {
                                CastProfileView(
                                    name: director.name,
                                    movieRole: director.job,
                                    imagePath: director.profile_path
                                )
                            }
                        }
                        .padding(.leading, 10)
                        
                        ForEach(casts, id: \.self) { cast in
                            NavigationLink(destination:
                                      CastMovieView(
                                        castName: cast.name,
                                        forDirector: false,
                                        type: .browseActor,
                                        castID: String( cast.castID ),
                                        imagePath: cast.picture)
                            ) {
                                CastProfileView(
                                    name: cast.name,
                                    movieRole: cast.character,
                                    imagePath: cast.picture
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.top, -20)
        }
    }
}

struct CastProfileView: View {
    let name: String
    let movieRole: String
    let imagePath: String?
    
    var body: some View {
        VStack(spacing: 0) {
            UrlImageView(path: imagePath, forProfile: true)
            
            VStack(spacing: 0) {
                // Name
                Text(name)
                    .movieFont(size: 13)
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                
                // Movie Role
                Text(movieRole)
                    .movieFont(size: 10)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(width: 110)
                    .lineLimit(nil)
            }
            .padding(.top, -20)
        }
        .padding(.bottom, 10)
        .padding(.trailing, 10)
    }
}
