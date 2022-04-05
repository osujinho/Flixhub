//
//  PersonAboutView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/27/22.
//

import SwiftUI

struct PersonAboutView: View {
    let detail: PersonDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            // For Birth year
            DetailLabelAndInfoView(label: "born", info: getDate(date: detail.birthday ,forYear: false))
            
            // For place of birth
            DetailLabelAndInfoView(label: "from", info: detail.birthPlace ?? "N/A")
            
            // For Deathday if available
            let deathdate = getDeathdate(date: detail.deathday)
            if deathdate.lowercased() != "alive" {
                DetailLabelAndInfoView(label: "died", info: deathdate)
            }
            
            // Biography view
            BiographyAndPlotView(
                biography: detail.biography,
                label: "biography")
            
            // Image scrollView
            PersonImageScrollView(images: detail.images.profiles)
        } /// End of Mother VStack
        .padding(.top, 10)
    }
}

struct PersonImageScrollView: View {
    let images: [MovieImage]
    
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
                                        ImageFullView(path: image.path, defaultImage: .profile)
                        ){
                            UrlImageView(path: image.path, defaultImage: .profile)
                                .frame(width: 100, height: 140)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}

