//
//  CarouselView.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct CarouselView: View {
     
    let categoryName: String
    let categoryNameBackgroundColor: Color
    let movies: [TMDBResult]
    let isPoster: Bool
    let imageUrl: String
    
    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .purple, location: 0),
            .init(color: .clear, location: 0.4)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
     
    var body: some View {
        VStack {
            HStack {
                Text(categoryName)
                    .font(.system(size: 14, weight: .heavy))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(categoryNameBackgroundColor)
                    .foregroundColor(.white)
                    .cornerRadius(2)
                Spacer()
            }.padding(.horizontal)
             
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(movies, id: \.self) { movie in
                        GeometryReader { proxy in
                            let scale = getScale(proxy: proxy)
                            NavigationLink(
                                // Destination to be changed
                                destination: DetailView( isUpcoming: isPoster, movieID: String(movie.tmdbID) ),
                                label: {
                                    PosterView(
                                        imageUrl: imageUrl.appending(isPoster ? movie.poster : movie.backdrop),
                                        titleOrDate: isPoster ? getDate(date: movie.releaseDate, forYear: false) : movie.title,
                                        
                                        isPoster: isPoster)
                                })
                                .scaleEffect(.init(width: scale, height: scale))
                                .animation(.easeOut, value: 1)
                                .padding(.vertical)
                        } //End Geometry
                        .frame(width: isPoster ? 145 : 235, height: isPoster ? 300 : 180)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 5)
                        .padding(.top, isPoster ? 20 : 5)
                    } //End ForEach
                    Spacer()
                        .frame(width: 10)
                } //End HStack
                .padding(.horizontal, 16)
            }// End ScrollView
        }//End VStack
    }
     
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 145
         
        let viewFrame = proxy.frame(in: .global).minX
         
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 145
         
        let diffFromCenter = abs(midPoint - viewFrame - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
         
        return scale
    }
}

