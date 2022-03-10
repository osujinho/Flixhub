//
//  MoviesViewBuilder.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation

// Function to get the imageURL
func getImageUrl(_ path: String?) -> String {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    return imageBaseUrl.appending(path ?? "")
}

// string to date
func getDate(date: String, forYear: Bool) -> String {
    let oldDateFormatter = DateFormatter()
    oldDateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Convert string to date
    guard let oldDate = oldDateFormatter.date(from: date) else { return "2000-01-01" }
    
    // convert date back to string in year format
    let newDateFormater = DateFormatter()
    newDateFormater.dateFormat = forYear ? "yyyy" : "MMM dd yyyy"
    
    return newDateFormater.string(from: oldDate)
}

// string to time
func stringToTime(strTime: Int) -> String {
    let totalMinutes = Double(strTime)
    
    let hours = Int(floor(totalMinutes / 60))
    let minutes = Int(totalMinutes) % 60
    
    return "\(hours)h \(minutes)mins"
}

enum DefaultImage: String, CaseIterable, Identifiable {
    case profile, poster, backdrop
    
    var id: DefaultImage { self }
}

