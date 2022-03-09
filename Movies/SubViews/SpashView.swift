//
//  SpashView.swift
//  Movies
//
//  Created by Michael Osuji on 3/9/22.
//

import SwiftUI

struct SpashView: View {
    var body: some View {
        VStack {
            Text("Loading Movies")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.blue.opacity(0.7))
                .padding(.bottom, 10)
            
            Image("appSplash")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.8 , height: UIScreen.main.bounds.height * 0.3, alignment: .center)
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue.opacity(0.7)))
                .scaleEffect(5)
        }
    }
}
