//
//  PersonDetailModel.swift
//  Movies
//
//  Created by Michael Osuji on 3/13/22.
//

import Foundation

struct PersonDetail: Hashable, Decodable {
    let name: String
    let birthday: String?
    let deathday: String?
    let knownFor: String?
    let gender: Int?
    let birthPlace: String?
    let profile: String?
    let biography: String?
    let credits: PersonCredit
    let images: ProfileImages
    
    enum CodingKeys: String, CodingKey {
        case name, biography, gender, birthday, deathday, images
        case knownFor = "known_for_department"
        case birthPlace = "place_of_birth"
        case profile = "profile_path"
        case credits = "combined_credits"
    }
}

struct ProfileImages: Hashable, Decodable {
    let profiles: [MovieImage]
}

struct PersonCredit: Hashable, Decodable {
    let cast: [CastForPerson]
    let crew: [CrewForPerson]
}

struct PersonMovieData: Hashable, Decodable {
    let title: String
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
    }
}

struct PersonShowData: Hashable, Decodable {
    let name: String
    let airDate: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "first_air_date"
    }
}

enum CastForPerson: Hashable, Decodable {
    case movie(CommonData, PersonMovieData)
    case tv(CommonData, PersonShowData)
    
    struct CommonData: Identifiable, Hashable, Decodable {
        var id = UUID()
        let tmdbID: Int
        let genres: [Int]
        let poster: String?
        let character: String?
        let rating: Double?
        let type: String
        
        enum CodingKeys: String, CodingKey {
            case character
            case poster = "poster_path"
            case type = "media_type"
            case rating = "vote_average"
            case genres = "genre_ids"
            case tmdbID = "id"
        }
    }
}

enum CrewForPerson: Hashable, Decodable {
    case movie(CommonData, PersonMovieData)
    case tv(CommonData, PersonShowData)
    
    struct CommonData: Hashable, Decodable, Identifiable {
        var id = UUID()
        let tmdbID: Int
        let genres: [Int]
        let poster: String?
        let rating: Double?
        let type: String
        let job: String?
        
        enum CodingKeys: String, CodingKey {
            case job
            case poster = "poster_path"
            case type = "media_type"
            case rating = "vote_average"
            case genres = "genre_ids"
            case tmdbID = "id"
        }
    }
}

extension CastForPerson {
    enum CodingKeys: String, CodingKey {
        case type = "media_type"
    }
    
    enum Types: String, Decodable {
        case movie, tv
    }
    
    var commonData: CommonData {
        switch self {
        case .movie(let data, _), .tv(let data, _):
            return data
        }
    }
    
    var type: Types {
        switch self {
        case .tv: return .tv
        case .movie: return .movie
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Types.self, forKey: .type)
        
        let commonData = try CommonData(from: decoder)
        
        switch type {
        case .movie:
            let movieData = try PersonMovieData(from: decoder)
            self = .movie(commonData, movieData)
        case .tv:
            let showData = try PersonShowData(from: decoder)
            self = .tv(commonData, showData)
        }
    }
}

extension CrewForPerson {
    enum CodingKeys: String, CodingKey {
        case type = "media_type"
    }
    
    enum Types: String, Decodable {
        case movie, tv
    }
    
    var commonData: CommonData {
        switch self {
        case .movie(let data, _), .tv(let data, _):
            return data
        }
    }
    
    var type: Types {
        switch self {
        case .movie: return .movie
        case .tv: return .tv
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Types.self, forKey: .type)
        
        let commonData = try CommonData(from: decoder)
        
        switch type {
        case .movie:
            let movieData = try PersonMovieData(from: decoder)
            self = .movie(commonData, movieData)
        case .tv:
            let showData = try PersonShowData(from: decoder)
            self = .tv(commonData, showData)
        }
    }
}
