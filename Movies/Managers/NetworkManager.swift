//
//  NetworkManager.swift
//  Movies
//
//  Created by Michael Osuji on 2/8/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidStatusCode
}

final class NetworkManager {
    public func makeCall<T: Codable>(url: String) async throws -> T {
        let urlSession = URLSession.shared
        guard let url = URL(string: url) else { throw NetworkError.badURL }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else { throw NetworkError.invalidStatusCode }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
