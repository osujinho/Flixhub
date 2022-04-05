//
//  DetailOptionsView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/21/22.
//

import SwiftUI

struct ImageGallery: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let images: [MovieImage]
    let defaultImage: DefaultImage
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            TabView{
                ForEach(images, id: \.self){ image in
                    UrlImageView(path: image.path, defaultImage: defaultImage)
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(5)
                        .padding(.horizontal, 10)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle())
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
                        .foregroundColor(.black)
                })
            }
        }
    }
}
