//
//  SynopsisView.swift
//  Movies
//
//  Created by Michael Osuji on 3/4/22.
//

import SwiftUI

struct SynopsisOrBiographyView: View {
    @Binding var isExpanded: Bool
    let synopsis: String?
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .movieFont(style: .title)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            if let synopsis = synopsis {
                if !isExpanded {
                    VStack(alignment: .leading) {
                        Text(synopsis)
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit( 2)
                            .padding(.bottom, 8)
                        Button(action: {
                            withAnimation {
                                isExpanded = true
                            }
                        }) {
                            Image(systemName: "chevron.down")
                                .foregroundColor(isExpanded ? .red.opacity(0.8) : .blue.opacity(0.8))
                        }
                    }
                } else {
                    ScrollView {
                        Text(synopsis)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            } else {
                Text("N/A")
            }
        }
        .movieFont(style: .body)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}
