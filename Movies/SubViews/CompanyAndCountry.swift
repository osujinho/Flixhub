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
        let width = label.widthOfString(usingFont: UIFont.systemFont(ofSize: 16, weight: .bold))
        let screenWidth = screen.width
        let spacingSize = (screenWidth * 0.5) - width
        
        HStack(alignment: .top, spacing: spacingSize) {
            Text(label.capitalized)
                .movieFont(style: .bold, size: labelSize)
                .foregroundColor(.secondary)
            
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
        }
    }
}
