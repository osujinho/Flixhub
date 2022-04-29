//
//  TrendingModel.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/29/22.
//

import Foundation

struct PersonData: Hashable, Decodable {
    let results: [PersonResult]
    let total_pages: Int
}

struct PersonResult: Hashable, Decodable {
    let name: String
    let id: Int
    let gender: Int?
    let department: String?
    let profile: String?
    
    enum CodingKeys: String, CodingKey {
        case name, id, gender
        case department = "known_for_department"
        case profile = "profile_path"
    }
}
