//
//  BiographyView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/27/22.
//

import SwiftUI

struct BiographyAndPlotView: View {
    @State private var isExpanded = false
    let biography: String?
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label.capitalized)
                .movieFont(style: .bold, size: labelSize)
                .foregroundColor(.secondary)
                .padding(.bottom, 5)
            
            if let biography = biography {
                VStack(alignment: .leading) {
                    Text(biography)
                        .lineLimit(isExpanded ? nil : 2)
                        .padding(.bottom, 8)
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(isExpanded ? .red.opacity(0.8) : .blue.opacity(0.8))
                    }
                }
            } else {
                Text("N/A")
            }
        }
        .movieFont(style: .regular, size: bodySize)
        .padding(.vertical, 10)
    }
}
