//
//  MovieRatingsView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/30/22.
//

import SwiftUI

struct CriticsRatingView: View {
    let ratings: [Ratings]?
    let outerWidth: Double = 0.5
    let imdb = "Internet Movie Database"
    let rt = "Rotten Tomatoes"
    let meta = "Metacritic"
    
    
    var body: some View {
        HStack(alignment: .top, spacing: getSpacing(label: "Ratings")) {
            Text("Ratings")
                .movieFont(style: .bold, size: labelSize)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 5) {
                
                // For IMDB
                HStack(alignment: .lastTextBaseline, spacing: 10) {
                    let width = "IMDb".widthOfString(usingFont: UIFont.systemFont(ofSize: 13))
                    Text("IMDb")
                        .movieFont(style: .bold, size: bodySize)
                        .frame(width: width + 5)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 4)
                        .background(Color.yellow)
                        .cornerRadius(5)
                    
                    let value = getRating(critic: .imdb)
                    let color = backgroundColor(value: value)
                    CriticValueView(value: value, color: color)
                }
                
                // For Rotten Tomatoes
                HStack(alignment: .lastTextBaseline, spacing: 33) {
                    Text("🍅")
                        .font(.system(size: 15))
                    
                    let value = getRating(critic: .rottenTomatoes)
                    let color = backgroundColor(value: value)
                    CriticValueView(value: value, color: color)
                }
                
                // For Meta
                HStack(alignment: .lastTextBaseline, spacing: 38) {
                    Image("meta")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    
                    let value = getRating(critic: .metacritic)
                    let color = backgroundColor(value: value)
                    CriticValueView(value: value, color: color)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func getSpacing(label: String) -> CGFloat {
        let width = label.widthOfString(usingFont: UIFont.systemFont(ofSize: 17))
        return (screen.width * outerWidth) - width
    }
    
    private func getRating(critic: CriticsRating) -> String {
        guard let ratings = ratings else { return "NR" }

        switch critic {
        case .imdb:
            for rating in ratings {
                if rating.source == meta {
                    if let valueString = rating.value.components(separatedBy: "/").first {
                        return valueString
                    }
                    return "NR"
                }
            }
            return "NR"
        case .rottenTomatoes:
            for rating in ratings {
                if rating.source == rt {
                    return rating.value
                }
            }
            return "NR"
            
        case .metacritic:
            for rating in ratings {
                if rating.source == meta {
                    if let valueString = rating.value.components(separatedBy: "/").first {
                        return valueString
                    }
                    return "NR"
                }
            }
            return "NR"
        }
    }
    
    private func backgroundColor(value: String) -> Color {
        guard value != "NR" else { return Color.gray }
        
        var ratingValue: Int = 0
        
        switch value {
        case _ where (value.contains("%")):
            guard let valueString = value.components(separatedBy: "%").first else { return Color.gray }
            guard let rottenValue = Int(valueString) else { return Color.gray }
            ratingValue = rottenValue
        case _ where (Int(value) != nil):
            guard let metaValue = Int(value) else { return Color.gray }
            ratingValue = metaValue
        case _ where (Double(value) != nil):
            guard let doubleValue = Double(value) else { return Color.gray }
            ratingValue = Int(doubleValue * 10)
        default:
            return Color.gray
        }
    
        // return color
        switch  ratingValue {
        case _ where (ratingValue <= 39): return Color.red
        case _ where (ratingValue >= 61): return Color.green
        default: return Color.yellow
        }
    }
}

struct CriticValueView: View {
    let value: String
    let color: Color
    
    var body: some View {
        Text(value)
            .movieFont(style: .regular, size: bodySize)
            .frame(width: 25)
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .background(color)
            .cornerRadius(5)
    }
}

enum CriticsRating: Identifiable, CustomStringConvertible {
    case imdb, rottenTomatoes, metacritic

    var id: CriticsRating { self }

    var description: String {
        switch self {
        case .imdb: return "Internet Movie Database"
        case .rottenTomatoes: return "Rotten Tomatoes"
        case .metacritic: return "Metacritic"
        }
    }
}
