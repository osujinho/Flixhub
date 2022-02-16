//
//  Extensions.swift
//  Movies
//
//  Created by Michael Osuji on 2/8/22.
//

import Foundation

// An extension to create the URL
extension URL {
    
    mutating func buildURL(queries: [String : String?]) {
        // unwrap the URL you want to use
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        
        // Create an array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        // Go through the dictionary and append each item into the query items array
        for query in queries {
            queryItems.append(URLQueryItem(name: query.key, value: query.value))
        }
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Return the url from new url components
        self = urlComponents.url!
    }
}

typealias Func = () -> Void
