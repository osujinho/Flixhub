//
//  ImageBackground.swift
//  Flixhub
//
//  Created by Michael Osuji on 3/19/22.
//

import SwiftUI

struct ImageBackground: View {
    @ObservedObject private var imageLoader: ImageLoader
    private let path: String?
    private let cache = CacheManager.cacheManager
    
    init(path: String?) {
        self.path = path
        self.imageLoader = ImageLoader(path)
    }
    
    var image: UIImage? {
        if let cacheImage = cache.get(name: path ?? "") {
            return cacheImage
        }
        return imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

