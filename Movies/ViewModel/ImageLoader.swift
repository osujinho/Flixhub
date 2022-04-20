//
//  ImageLoader.swift
//  Movies
//
//  Created by Michael Osuji on 3/7/22.
//

import SwiftUI /// So I can use UIImage

final class ImageLoader: ObservableObject {
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    private let cache = CacheManager.cacheManager
    private var task: URLSessionDataTask?

    @Published var data: Data?
    @Published var isLoading: Bool = true

    init(_ path: String?, forThumbnail: Bool) {
        self.isLoading = true
        
        guard let path = path else { return }
        let urlString = imageBaseUrl.appending(path)
        let thumbnailUrlString = "https://img.youtube.com/vi/\(path)/hqdefault.jpg"
        
        guard let url = URL(string: forThumbnail ? thumbnailUrlString : urlString) else { return }
        
        task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let imageToCache = UIImage(data: data) {
                self.cache.add(image: imageToCache, name: path)
            }
            DispatchQueue.main.async {
                self.data = data
                self.isLoading = false
            }
        }
        task?.resume()
    }

    deinit {
      task?.cancel()
    }
}

enum DefaultImage: String, CaseIterable, Identifiable {
    case profile, poster, backdrop
    
    var id: DefaultImage { self }
}

