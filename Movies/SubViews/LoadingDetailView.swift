//
//  LoadingDetailView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI

struct LoadingDetailView: View {
    let movieTitle: String
    
    var body: some View {
        VStack {
            Text("Loading Details on \(movieTitle)")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            Image("avengers")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.7 , height: UIScreen.main.bounds.height * 0.5)
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue.opacity(0.7)))
                .scaleEffect(5)
        }
    }
}
