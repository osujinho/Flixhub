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
    private let defaultImage: DefaultImage.RawValue
    private let forProfile: Bool
    private let cache = CacheManager.cacheManager
    
    init(path: String?, defaultImage: DefaultImage.RawValue, forProfile: Bool = false) {
        self.path = path
        self.defaultImage = defaultImage
        self.forProfile = forProfile
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
        /// Still looking up Image for the given path
        if imageLoader.isLoading {
            Image(defaultImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .if(forProfile) { view in
                    view
                        .frame(width: 100, height: 100)
                }
                .foregroundColor(.gray)
                .overlay(
                    ProgressView()
                )
        } else {
            /// Image returned for the given path
            if let loadedImage = image {
                Image(uiImage: loadedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .transition(.slide)
            } else {
                /// No Image returned for the given path
                Image(systemName: forProfile ? "person.circle.fill" : "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .overlay(
                        Image(systemName: "exclamationmark.icloud")
                            .font(.system(size: 25).bold())
                            .foregroundColor(Color.orange)
                    )
            }
        }
    }
}

