//
//  CompanyAndCountry.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/1/22.
//

import SwiftUI

struct CompanyAndCountry: View {
    let label: String
    let items: [Name]
    
    var body: some View {
        
        HStack(alignment: .top) {
            Text(label.capitalized)
                .detailLabelViewModifier()
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 5) {
                if items.isEmpty {
                    Text("N/A")
                } else {
                    ForEach(items, id: \.self) { item in
                        if let name = item.name {
                            Text(name.capitalized)
                        } else {
                            Text("N/A")
                        }
                    }
                }
            }
            .movieFont(style: .regular, size: bodySize)
            .multilineTextAlignment(.leading)
            .frame(width: screen.width * 0.4, alignment: .leading)
        }
        .padding(.horizontal)
    }
}
