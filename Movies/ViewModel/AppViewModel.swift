//
//  MoviesViewBuilder.swift
//  Movies
//
//  Created by Michael Osuji on 2/1/22.
//

import Foundation

//@MainActor class AppViewModel: ObservableObject {
//    @Published private(set) var showBrowseViewModel = ShowBrowseViewModel()
//    
//}

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

// get death date in string
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

// Get age in strings
func getAge(birthDate: String?) -> String {
    guard let birthDate = birthDate else { return "N/A" }
    
    let birthdayFormat = DateFormatter()
    birthdayFormat.dateFormat = "yyyy-MM-dd"
    
    guard let birthdayDate = birthdayFormat.date(from: birthDate) else {  return "N/A"}
    
    let today = Date()
    let calender = Calendar.current
    
    let ageComponents = calender.dateComponents([.year], from: birthdayDate, to: today)
    guard let age = ageComponents.year else { return "N/A" }
    return String(age) + " years"
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

func getLanguage(code: String?) -> String {
    guard let languageCode = code else { return "N/A"}
    
    let usLocale = Locale(identifier: "en-US")
    if let languageName = usLocale.localizedString(forLanguageCode: languageCode) {
        return languageName
    }
    return "N/A"
}

func getCountry(countryCode: String) -> String {
    let usLocale = Locale(identifier: "en-US")
    if let countryName = usLocale.localizedString(forRegionCode: countryCode) {
        return countryName
    }
    return "N/A"
}

func getMoney(amount: Int?) -> String {
    guard let amount = amount else { return "N/A" }
    if amount <= 0 { return "N/A" }
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 0
    if let stringAmount = formatter.string(from: NSNumber(value: amount)) {
        return stringAmount
    }
    return "N/A"
}

func tmdbRating(rating: Double?) -> String {
    guard let rating = rating else { return "NR" }
    
    return String(rating)
}
