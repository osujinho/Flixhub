//
//  ImageFullView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/27/22.
//

import SwiftUI

struct ImageFullView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let path: String?
    let defaultImage: DefaultImage
    let width = screen.width * 0.9
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            ScrollView(.vertical) {
                UrlImageView(path: path, defaultImage: defaultImage)
                    .scaledToFit()
                    .frame(
                        width: width,
                        height: defaultImage == .backdrop ? (width / 1.78) : ( width * 1.5 )
                    )
                    .cornerRadius(5)
                    .padding(.horizontal, 10)
            }
            .background(Color("background"))
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
        }
    }
}
