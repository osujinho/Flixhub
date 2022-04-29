//
//  PersonPosterView.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/29/22.
//

import SwiftUI

struct PersonPosterView: View {
    let name: String
    let imagePath: String?
    let gender: Int?
    let department: String?
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 0.4)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        UrlImageView(path: imagePath, defaultImage: .profile)
            .frame(width: 120, height: 180)
            .overlay(
                ZStack(alignment: .bottom) {
                    UrlImageView(path: imagePath, defaultImage: .poster)
                        .frame(width: 120, height: 180)
                        .blur(radius: 20) /// blur the image
                        .padding(-20) /// expand the blur a bit to cover the edges
                        .padding(.bottom, 10)
                        .clipped() /// prevent blur overflow
                        .mask(gradient) /// mask the blurred image using the gradient's alpha values
                    
                    gradient /// also add the gradient as an overlay (this time, the purple will show up)
                }
            )
            .padding(.bottom, 70)
            .background(posterLabelColor)
            .overlay(
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 3)
                        
                        Text(getGender(genderNumber: gender))
                            .font(.system(size: 11))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.bottom, 2)
                        
                        if let department = department {
                            HStack(spacing: 0) {
                                Text("Known for ")
                                    .foregroundColor(.white.opacity(0.7))
                                
                                Text(department)
                                    .foregroundColor(.white)
                            }
                            .font(.system(size: 11))
                            .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.horizontal, 5)
                    .background(posterLabelColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 8)
            )
            .cornerRadius(5)
    }
}
