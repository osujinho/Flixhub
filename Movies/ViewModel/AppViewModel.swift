//
//  MoviesViewBuilder.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation

// string to date
func getDate(date: String?, forYear: Bool) -> String {
    guard let date = date else { return "N/A" }
    
    let oldDateFormatter = DateFormatter()
    oldDateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Convert string to date
    guard let oldDate = oldDateFormatter.date(from: date) else { return "N/A" }
    
    // convert date back to string in year format
    let newDateFormater = DateFormatter()
    newDateFormater.dateFormat = forYear ? "yyyy" : "dd MMM yyyy"
    
    return newDateFormater.string(from: oldDate)
}

func getDeathdate(date: String?) -> String {
    guard let date = date else { return "Alive" }
    
    let oldDateFormatter = DateFormatter()
    oldDateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Convert string to date
    guard let oldDate = oldDateFormatter.date(from: date) else { return "N/A" }
    
    // convert date back to string in year format
    let newDateFormater = DateFormatter()
    newDateFormater.dateFormat = "dd MMM yyyy"
    
    return newDateFormater.string(from: oldDate)
}

// string to time
func stringToTime(strTime: Int?) -> String {
    guard let strTime = strTime else { return "N/A" }
    let totalMinutes = Double(strTime)
    
    let hours = Int(floor(totalMinutes / 60))
    let minutes = Int(totalMinutes) % 60
    
    return "\(hours)h \(minutes)mins"
}

func unwrapNumbersToString(_ number: Int?) -> String {
    guard let number = number else { return "N/A" }
    return String(number)
}

func getGender(genderNumber: Int?) -> String {
    guard let genderNumber = genderNumber else {
        return "Not Specified"
    }
    
    switch genderNumber {
    case _ where genderNumber == 1: return "Female"
    case _ where genderNumber == 2: return "Male"
    case _ where genderNumber == 3: return "Non-Binary"
    default: return "Not Specified"
    }
}

func tmdbRating(rating: Double?) -> String {
    guard let rating = rating else { return "NR" }
    
    return String(rating)
}
