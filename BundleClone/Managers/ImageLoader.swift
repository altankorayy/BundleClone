//
//  ImageLoader.swift
//  BundleClone
//
//  Created by Altan on 26.11.2023.
//

import Foundation

class ImageLoader {
    
    static let shared = ImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    public func downloadImage(_ url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        
        //Image Caching
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
