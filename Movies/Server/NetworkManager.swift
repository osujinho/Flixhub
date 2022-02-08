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
    public func makeCall<T: Codable>(url: URL) async throws -> T {
        let urlSession = URLSession.shared
        let (data, response) = try await urlSession.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else { throw NetworkError.invalidStatusCode }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
