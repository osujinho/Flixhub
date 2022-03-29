//
//  CustomViews.swift
//  Movies
//
//  Created by Michael Osuji on 2/15/22.
//

import SwiftUI

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

struct GridViewToggle: View {
    @Binding var showGridView: Bool
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(action: {
                withAnimation {
                    showGridView.toggle()
                }
            }, label: {
                Image(systemName: showGridView ? "list.bullet.circle.fill" : "circle.grid.3x3.circle.fill")
                    .renderingMode(.template)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary) /// Fix after implementing Both dark and light mode
            })
        }
    }
}

struct LabelAndInfoView: View {
    let label: String
    let info: String
    let forMedia: Bool
    let spacingSize: CGFloat
    
    init(label: String, info: String, forMedia: Bool = false, spacingSize: CGFloat = 20) {
        self.label = label
        self.info = info
        self.forMedia = forMedia
        self.spacingSize = spacingSize
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: spacingSize) {
            Text(label.capitalized)
                .movieFont(style: .bold, size: labelSize)
            Text(info)
                .movieFont(style: .regular, size: bodySize)
                .multilineTextAlignment(.leading)
                .if(forMedia) { view in
                    view
                        .foregroundColor(info.lowercased() == "movies" ? .blue.opacity(0.8) : .yellow.opacity(0.8))
                }
        }
    }
}

struct RatedAndRatingView: View {
    let label: String
    let info: String
    let forRating: Bool
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            Text(label.capitalized)
                .movieFont(style: .bold, size: labelSize)
            Text(info)
                .ratedAndRatingViewModifier(borderColor: forRating ? .red : .blue)
        }
    }
}
