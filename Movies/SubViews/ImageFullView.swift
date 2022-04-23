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
            UrlImageView(path: path, defaultImage: defaultImage)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(5)
                .padding(.horizontal, 10)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    UIViewController.attemptRotationToDeviceOrientation()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .renderingMode(.original)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black) /// Fix after implementing Both dark and light mode
                })
            }
        }
        .onAppear {
            if defaultImage == .backdrop {
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") // Forcing the rotation to landscape
                AppDelegate.orientationLock = .landscape // And making sure it stays that way
            }
        }
    }
}
