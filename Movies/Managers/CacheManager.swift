//
//  CacheManager.swift
//  Movies
//
//  Created by Michael Osuji on 3/7/22.
//
import SwiftUI

class CacheManager {
    static let cacheManager = CacheManager()   // This creates a singleton, almost like a global variable.
    
    private init(){}   /// restricts instantiation of another Cache manager
    
    /// NS Stands for Next Step, it is a programming language before ObjectiveC
    var imageCache: NSCache<NSString, UIImage> = {
        ///  We are computing the cache so that we can customize it a bit before we return it
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100   /// Maximum number of objects the cache can hold
        
        /// Total Mb or Gb size the cache can hold before deleting items
        cache.totalCostLimit = 1024 * 1024 * 100   /// 100 mb
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString) /// Cast the name (String) as NSString
        
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func get(name: String) -> UIImage? {   /// Optional in case it is not in the cache
        imageCache.object(forKey: name as NSString)
    }
}
