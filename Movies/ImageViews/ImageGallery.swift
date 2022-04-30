//
//  DetailOptionsView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/21/22.
//

import SwiftUI

struct ImageGallery: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appViewModel: AppViewModel
    let images: [String?]
    let defaultImage: DefaultImage
    let posterMaxWidth = 0.9 * screen.width
    let backdropMaxWidth = 0.9 * screen.height
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            TabView{
                ForEach(images, id: \.self){ image in
                    NavigationLink(destination: ImageFullView(path: image, defaultImage: defaultImage)) {
                        
                        UrlImageView(path: image, defaultImage: defaultImage)
                            .scaledToFit()
                            .frame(maxWidth: defaultImage == .backdrop ? backdropMaxWidth : posterMaxWidth)
                            .cornerRadius(5)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    if defaultImage == .backdrop {
                        AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                        UIViewController.attemptRotationToDeviceOrientation()
                    }
                    appViewModel.showFullImageView = false
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .renderingMode(.original)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                })
            }
        }
        .onAppear {
            appViewModel.showFullImageView = true
            if defaultImage == .backdrop {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                UIViewController.attemptRotationToDeviceOrientation()
            }
        }
    }
}
