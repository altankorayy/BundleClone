//
//  BundleCloneTests.swift
//  BundleCloneTests
//
//  Created by Altan on 12.11.2023.
//

import XCTest
@testable import BundleClone

final class BundleCloneTests: XCTestCase {
    
    func testAPIRequestWithoutQuery() {
        let apiRequest = APIRequest(endpoint: .science, query: nil)
        let url = apiRequest.url?.absoluteString
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url, "https://newsapi.org/v2/everything?q=science&apiKey=13db935e5efa423bb441b050f1b52826")
    }
    
    func testAPIRequestWithQuery() {
        let apiRequest = APIRequest(endpoint: .search, query: "science")
        let urlWithQuery = apiRequest.searchUrl?.absoluteString
        
        XCTAssertNotNil(urlWithQuery)
        XCTAssertEqual(urlWithQuery, "https://newsapi.org/v2/everything?q=science&apiKey=13db935e5efa423bb441b050f1b52826")
    }
    
    func testExecute() {
        let request = APIRequest(endpoint: .science, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
            }
        }
    }
    
    func testSearch() {
        let request = APIRequest(endpoint: .search, query: "science")
        
        APIService.shared.search(request, expecting: NewsModelResponse.self) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
            }
        }
    }
    
    func testCachedResponse() {
        let cacheManager = APICacheManager()
        let endpoint = APIEndpoint.science
        let url = URL(string: "https://example.com")
        let testData = "Test Data".data(using: .utf8)!
        
        cacheManager.setCache(for: endpoint, url: url, data: testData)
        
        let cachedData = cacheManager.cachedResponse(for: endpoint, url: url)
        
        XCTAssertNotNil(cachedData)
        XCTAssertEqual(cachedData, testData)
    }
    
    func testDownloadImage() {
        let imageUrl = URL(string: "https://media.licdn.com/dms/image/C4D03AQHU3e7C1bmBrA/profile-displayphoto-shrink_400_400/0/1625376796635?e=1707955200&v=beta&t=tnj4PULlbESzUFkrMS6jNdOShE-kzGQFrgX4eqhVBJY")!
        
        ImageLoader.shared.downloadImage(imageUrl) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
            }
        }
    }
}
