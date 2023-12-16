//
//  APICacheManager.swift
//  BundleClone
//
//  Created by Altan on 28.11.2023.
//

import Foundation

class APICacheManager {
        
    private var cacheDictionary: [APIEndpoint: NSCache<NSString, NSData>] = [:]
    
    init() {
        setupCache()
    }
    
    public func cachedResponse(for endpoint: APIEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else { return nil }
        
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: APIEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else { return }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    public func setupCache() {
        APIEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
}
