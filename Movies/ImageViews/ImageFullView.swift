//
//  ImageFullView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/27/22.
//

import SwiftUI

struct ImageFullView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appViewModel: AppViewModel
    let path: String?
    let defaultImage: DefaultImage
    let posterMaxWidth = screen.width * 0.98
    let backdropMaxWidth = screen.height * 0.98
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea([.all])
            
            UrlImageView(path: path, defaultImage: defaultImage)
                .scaledToFit()
                .frame(maxWidth: defaultImage == .backdrop ? backdropMaxWidth : posterMaxWidth)
                .cornerRadius(5)
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
