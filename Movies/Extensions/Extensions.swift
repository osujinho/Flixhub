//
//  Extensions.swift
//  Movies
//
//  Created by Michael Osuji on 2/8/22.
//

import SwiftUI

typealias Func = () -> Void

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

// Creates a conditional View Modifier based on a boolean
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

/// To Get the width of a String based on the font
extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

/*
    Use as follows
 let width = "SomeString".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
 */
