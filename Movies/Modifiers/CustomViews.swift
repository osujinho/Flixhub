//
//  CustomViews.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

// Container label Texts
struct HeadlineLabel: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.subheadline)
            .fontWeight(.semibold)
    }
}

/// To round only certain corners
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
