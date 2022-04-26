//
//  CustomViews.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

/// For Inside movie and show DetailView - about section
struct DetailLabelAndInfoView: View {
    let label: String
    let info: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(label.capitalized)
                .detailLabelViewModifier()
            
            Spacer()
            
            Text(info)
                .detailInfoViewModifier()
        }
        .padding(.horizontal)
    }
}

/// For inside a list Row in getMore or result row in searchView
struct RowLabelAndInfoView: View {
    let label: String
    let info: String
    let width: CGFloat
    
    var body: some View {
        
        HStack(alignment: .top) {
            Text(label.capitalized)
                .rowLabelViewModifier(width: width)
            
            Spacer()
            
            Text(info.capitalized)
                .fixedSize(horizontal: false, vertical: true)
                .rowInfoViewModifier(width: width)
        }
    }
}

struct CustomShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}

struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
