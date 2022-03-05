//
//  SynopsisView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI

struct SynopsisView: View {
    @State private var isExpanded = false
    let syposis: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Synopsis")
                .movieFont(size: 23)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            Text(syposis)
                .movieFont(size: 14)
                .foregroundColor(.white.opacity(0.7))
                .lineLimit(isExpanded ? nil : 2)
                .padding(.bottom, 8)
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}
