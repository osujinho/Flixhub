//
//  SearchModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/12/22.
//

import Foundation

struct Search: Hashable, Decodable {
    let results: [SearchResult]
}

enum SearchResult: Hashable, Decodable {
    case movie(CommonData, MovieData)
    case tv(CommonData, ShowData)
    case person(CommonData, PersonData)
    
    struct CommonData: Hashable, Decodable {
        let id: Int
        let type: String
        
        enum CodingKeys: String, CodingKey {
            case type = "media_type"
            case id
        }
    }
    
    struct MovieData: Hashable, Decodable {
        let title: String
        let poster: String?
        let date: String?
        
        enum CodingKeys: String, CodingKey {
            case poster = "poster_path"
            case date = "release_date"
            case title
        }
    }
    
    struct ShowData: Hashable, Decodable {
        let name: String
        let poster: String?
        let date: String?
        
        enum CodingKeys: String, CodingKey {
            case poster = "poster_path"
            case date = "first_air_date"
            case name
        }
    }
    
    struct PersonData: Hashable, Decodable {
        let name: String
        let gender: Int?
        let profile: String?
        let knownFor: String?
        
        enum CodingKeys: String, CodingKey {
            case profile = "profile_path"
            case knownFor = "known_for_department"
            case name, gender
        }
    }
}

extension SearchResult {
    enum CodingKeys: String, CodingKey {
        case type = "media_type"
    }
    
    enum Types: String, Decodable {
        case movie, tv, person
    }
    
    var commonData: CommonData {
        switch self {
        case .movie(let data, _), .tv(let data, _), .person(let data, _):
            return data
        }
    }
    
    var type: Types {
        switch self {
        case .movie: return .movie
        case .tv: return .tv
        case .person: return .person
        }
    }
    
    var data: [Any?] {
        switch self {
        case let .movie(_, movieData):
            return [movieData.poster, movieData.date, movieData.title]
        case let .tv(_, showData):
            return [showData.poster, showData.date, showData.name]
        case let .person(_, personData):
            return [personData.profile, personData.name, personData.knownFor]
        }
    }
    
    init(from decoder: Decoder) throws {
        /// Extract type
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Types.self, forKey: .type)
        
        /// extract common data
        let commonData = try CommonData(from: decoder)
        
        /// extract type specific data
        switch type {
        case .movie:
            let movieData = try MovieData(from: decoder)
            self = .movie(commonData, movieData)
        case .tv:
            let showData = try ShowData(from: decoder)
            self = .tv(commonData, showData)
        case .person:
            let personData = try PersonData(from: decoder)
            self = .person(commonData, personData)
        }
    }
}

