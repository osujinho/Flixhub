//
//  PersonMoreImageModel.swift
//  Flixhub
//
//  Created by Michael Osuji on 4/5/22.
//

import Foundation

// More Images
struct MorePersonImage: Hashable, Decodable {
    let results: [ImageResult]
}

struct ImageResult: Hashable, Decodable {
    let media: ImageMedia
}

struct ImageMedia: Hashable, Decodable {
    let backdrop: String?
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
    }
}
