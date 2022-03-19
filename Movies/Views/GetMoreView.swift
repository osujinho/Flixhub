//
//  GetMoreView.swift
//  Movies
//
//  Created by Michael Osuji on 3/18/22.
//

import SwiftUI

struct GetMoreView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let header: String
    let movies: [TMDBResult]
    let totalPages: Int
    
    var body: some View {
        VStack {
            List{
                ForEach(movies, id: \.self){ movie in
                    NavigationLink(destination:
                                    MovieDetailView(
                                        movieID: String( movie.tmdbID ),
                                        movieTitle: movie.title,
                                        imagePath: movie.poster
                                    )
                    ) {
                        GetMoreRowView(movie: movie)
                    }
                }
            }
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
            
            ToolbarItem(placement: .principal) {
                Text(header)
                    .movieFont(style: .name)
            }
        }
    }
}

// Implement Infinite scroll
