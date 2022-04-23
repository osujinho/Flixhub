//
//  VideoPlayerView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/23/22.
//

import SwiftUI
import YouTubePlayerKit

struct VideoPlayerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let videoID: String
        
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            YouTubePlayerView(
                .init(
                    source: .video(id: videoID),
                    configuration: .init(
                        isUserInteractionEnabled: true,
                        autoPlay: true,
                        playInline: false
                    )
                )
            )
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
            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
}
