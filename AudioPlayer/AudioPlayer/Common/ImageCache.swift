//
//  ImageCache.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 25/11/2023.
//
import UIKit

// To make your code more extensible, Create a protocol for the cache and have your ImageCache class implement it. This way, we can easily swap out the caching implementation in the future.

protocol ImageCaching {
    func cacheImage(_ image: UIImage, for url: URL)
    func image(for url: URL) -> UIImage?
}


class ImageCache: ImageCaching {

    private var cache = NSCache<NSString, UIImage>()
    
    func cacheImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }

    func image(for url: URL) -> UIImage? {
        if let cachedImageData = cache.object(forKey: url.absoluteString as NSString) as UIImage? {
            return cachedImageData
        }
        return nil
    }
}
