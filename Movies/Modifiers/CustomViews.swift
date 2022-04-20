//
//  CustomViews.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

struct DetailLabelAndInfoView: View {
    let label: String
    let info: String
    let widthPercent: Double = 0.5
    
    init(label: String, info: String) {
        self.label = label
        self.info = info
    }
    
    var body: some View {
        let labelWidth = label.widthOfString(usingFont: UIFont.systemFont(ofSize: 16, weight: .bold))
        let spacingSize = (screen.width * widthPercent) - labelWidth
        
        HStack(alignment: .top, spacing: spacingSize) {
            Text(label.capitalized)
                .movieFont(style: .bold, size: labelSize)
                .foregroundColor(.secondary)
            Text(info)
                .movieFont(style: .regular, size: bodySize)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }
}

struct RowLabelAndInfoView: View {
    let label: String
    let info: String
    let forMedia: Bool
    let widthPercent: Double = 0.2
    
    init(label: String, info: String, forMedia: Bool = false) {
        self.label = label
        self.info = info
        self.forMedia = forMedia
    }
    
    var body: some View {
        let labelWidth = label.widthOfString(usingFont: UIFont.systemFont(ofSize: 16, weight: .bold))
        let spacingSize = (screen.width * widthPercent) - labelWidth
        
        HStack(alignment: .bottom, spacing: spacingSize) {
            Text(label.capitalized)
                .movieFont(style: .bold, size: labelSize)
            Text(info.capitalized)
                .movieFont(style: .regular, size: bodySize)
                .multilineTextAlignment(.leading)
                .if(forMedia) { view in
                    view
                        .foregroundColor(info.lowercased() == "movies" ? .blue.opacity(0.8) : .yellow.opacity(0.8))
                }
        }
    }
}

struct CustomShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}
