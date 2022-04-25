//
//  PersonImageViews.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/5/22.
//

import SwiftUI

struct PersonPosterScrollView: View {
    let images: [String?]
    let posterWidth: Double = 100
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Images")
                    .movieFont(style: .bold, size: labelSize)
                    .foregroundColor(.secondary)
                Spacer()
                
                NavigationLink(destination:
                                ImageGallery(
                                    images: images,
                                    defaultImage: .profile)
                ){
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10))
                }
                
            }.padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .bottom, spacing: 10) {
                    ForEach(images, id: \.self) { image in
                        NavigationLink(destination:
                                        ImageFullView(path: image, defaultImage: .profile)
                        ){
                            UrlImageView(path: image, defaultImage: .profile)
                                .frame(width: CGFloat(posterWidth), height: CGFloat(posterWidth * 1.5))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}

struct PersonBackdropScrollView: View {
    let images: [String?]
    let backdropheight: Double = 150
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Tagged Images")
                    .movieFont(style: .bold, size: labelSize)
                    .foregroundColor(.secondary)
                Spacer()
                
                NavigationLink(destination:
                                ImageGallery(
                                    images: images,
                                    defaultImage: .backdrop)
                ){
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10))
                }
                
            }.padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .bottom, spacing: 10) {
                    ForEach(images, id: \.self) { image in
                        NavigationLink(destination:
                                        ImageFullView(path: image, defaultImage: .backdrop)
                        ){
                            UrlImageView(path: image, defaultImage: .backdrop)
                                .frame(width: CGFloat(backdropheight * 1.778), height: CGFloat(backdropheight))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}
