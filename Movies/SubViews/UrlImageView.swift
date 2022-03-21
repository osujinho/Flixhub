//
//  MovieOrProfileImage.swift
//  Movies
//
//  Created by Michael Osuji on 3/7/22.
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject private var imageLoader: ImageLoader
    private let path: String?
    private let defaultImage: DefaultImage
    private let cache = CacheManager.cacheManager
    
    init(path: String?, defaultImage: DefaultImage) {
        self.path = path
        self.defaultImage = defaultImage
        self.imageLoader = ImageLoader(path)
    }
    
    var image: UIImage? {
        /// Image exists in the cache so we return it
        if let imageFromCache = cache.get(name: path ?? "") {
            return imageFromCache
        }
        /// Image is not in the cache so we do a network call to get ot
        return imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        /// looking up Image for the given path
        Group {
            switch path {
            case _ where (path == nil):
                Image(defaultImage.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case _ where (cache.get(name: path ?? "") != nil):
                if let cacheImage = cache.get(name: path ?? "") {
                    Image(uiImage: cacheImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            default:
                /// Return progress View
                if imageLoader.isLoading {
                    Image(defaultImage.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(
                            ProgressView()
                        )
                    /// Return loaded Image
                } else if let loadedImage = imageLoader.data.flatMap(UIImage.init) {
                    Image(uiImage: loadedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .transition(.slide)
                    /// Return Placeholder
                } else {
                    Image(defaultImage.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
        }
    }
}

