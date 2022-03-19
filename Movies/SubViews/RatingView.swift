//
//  RatingView.swift
//  Movies
//
//  Created by Michael Osuji on 3/18/22.
//

import SwiftUI

struct RatingView: View {
    let rating: Double?
    let frameSize: Int
    
    var ratingString: String {
        if let rating = rating {
            if rating == 0 {
                return "NR"
            }
            return String(Int(rating * 10))
        }
        return "NR"
    }
    
    var ratingPercent: CGFloat {
        if let rating = rating {
            return CGFloat( Int( ( rating / 10 ) * 100 ) )
        }
        return CGFloat(0)
    }
    
    var ratingColor: Color {
        if let rating = rating {
            let centRating = Int(rating * 10)
            
            switch centRating {
            case _ where (centRating <= 0): return Color.white.opacity(0.7)
            case _ where ((1...29).contains(centRating)):
                return (Color(red: 255 / 255.0, green: 0 / 255.0, blue: 0 / 255.0))
            case _ where ((30...44).contains(centRating)):
                return (Color(red: 255 / 255.0, green: 167 / 255.0, blue: 0 / 255.0))
            case _ where ((45...64).contains(centRating)):
                return (Color(red: 255 / 255.0, green: 244 / 255.0, blue: 0 / 255.0))
            case _ where ((65...84).contains(centRating)):
                return (Color(red: 163 / 255.0, green: 255 / 255.0, blue: 0 / 255.0))
            case _ where (centRating >= 85):
                return (Color(red: 44 / 255.0, green: 186 / 255.0, blue: 0 / 255.0))
            default: return Color.gray.opacity(0)
            }
        }
        return Color.gray.opacity(0)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3.0)
                .opacity(0.3)
                .foregroundColor(ratingColor.opacity( rating ?? 0.0 > 0.0 ? 0.5 : 1))

            Circle()
                .trim(from: 0.0, to: ratingPercent/100)
                .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(ratingColor)
                .rotationEffect(Angle(degrees: 270.0))
            
            Text(ratingString)
                .foregroundColor(.white)
                .font(.system(size: 13, weight: .bold))
        }
        .frame(width: CGFloat( frameSize ), height: CGFloat( frameSize ))
        .padding(4)
        .background(posterLabelColor)
        .clipShape(Circle())
    }
}
