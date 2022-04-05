//
//  MovieRatingsView.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/30/22.
//

import SwiftUI

struct MovieRatingsView: View {
    let ratings: [Ratings]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ratings")
                .movieFont(style: .bold, size: labelSize)
                .foregroundColor(.secondary)
            VStack(alignment: .leading, spacing: 5) {
                ForEach(ratings, id:\.self) { rating in
                    HStack(alignment: .firstTextBaseline) {
                        Text(rating.source.capitalized)
                            .movieFont(style: .regular, size: bodySize)
                            .foregroundColor(.secondary)
                        
                        let nameWidth = rating.source.widthOfString(usingFont: UIFont.systemFont(ofSize: 15))
                        let screenSize = UIScreen.main.bounds.width
                        let width = (screenSize * 0.6) - nameWidth
                        Spacer()
                            .frame(width: width)
                        
                        HStack(alignment: .lastTextBaseline, spacing: 10) {
                            // For the icon
                            switch rating {
                            case _ where (rating.source.lowercased().contains("internet")):
                                let width = "IMDb".widthOfString(usingFont: UIFont.systemFont(ofSize: 13))
                                Text("IMDb")
                                    .movieFont(style: .bold, size: bodySize)
                                    .frame(width: width + 5)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 4)
                                    .background(Color.yellow)
                                    .cornerRadius(5)
                            case _ where (rating.source.lowercased().contains("rotten")):
                                Text("🍅")
                                    .font(.system(size: 15))
                            default:
                                Image("meta")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                            }
                            // for the value
                            RatingValueView(rating: rating)
                        }
                        Spacer()
                    }
                    
                }
            }
        }
    }
}

struct RatingValueView: View {
    let rating: Ratings
    
    var body: some View {
        Text(valueString())
            .movieFont(style: .regular, size: bodySize)
            .frame(width: 25)
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .background(backgroundColor())
            .cornerRadius(5)
    }
    
    func backgroundColor() -> Color {
        switch rating {
        case _ where (rating.source.lowercased().contains("internet")):
            guard let valueString = rating.value.components(separatedBy: "/").first else { return Color.gray }
            guard let value = Double(valueString) else { return Color.gray }
            let centValue = Int(value * 10)
            
            switch centValue {
            case _ where (centValue <= 39) : return Color.red
            case _ where (centValue >= 61): return Color.green
            default: return Color.yellow
            }
            
        case _ where (rating.source.lowercased().contains("rotten")):
            guard let valueString = rating.value.components(separatedBy: "%").first else { return Color.gray }
            guard let value = Int(valueString) else { return Color.gray }
            
            switch value {
            case _ where (value <= 39): return Color.red
            case _ where (value >= 61): return Color.green
            default: return Color.yellow
            }
            
        default:
            guard let valueString = rating.value.components(separatedBy: "/").first else { return Color.gray }
            guard let value = Int(valueString) else { return Color.gray }
            
            switch value {
            case _ where (value <= 39): return Color.red
            case _ where (value >= 61): return Color.green
            default: return Color.yellow
            }
        }
    }
    
    func valueString() -> String {
        switch rating {
        case _ where (rating.source.lowercased().contains("internet")):
            if let valueString = rating.value.components(separatedBy: "/").first {
                return valueString
            }
            return "N/A"
        case _ where (rating.source.lowercased().contains("rotten")):
            return rating.value
        default:
            if let valueString = rating.value.components(separatedBy: "/").first {
                return valueString
            }
            return "N/A"
        }
    }
}

