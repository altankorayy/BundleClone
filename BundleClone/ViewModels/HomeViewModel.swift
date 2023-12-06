//
//  HomeViewModel.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import Foundation

protocol NewsTopHeadlines: AnyObject {
    func topHeadlines(_ model: [Article])
    func appleNews(_ model: [Article])
}

class HomeViewModel {
    
    weak var delegate: NewsTopHeadlines?
    
    public func fetchAppleNews() {
        let request = APIRequest(endpoint: .appleNews, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.appleNews(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchTopHeadlines() {
        let request = APIRequest(endpoint: .topHeadlines, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.topHeadlines(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
