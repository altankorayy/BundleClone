//
//  FeaturedTableViewHeaderViewModel.swift
//  BundleClone
//
//  Created by Altan on 29.11.2023.
//

import Foundation

protocol FeaturedTableViewHeaderModel: AnyObject {
    func fetchStoryNews(_ model: [Article])
}

class FeaturedTableViewHeaderViewModel {
    
    weak var delegate: FeaturedTableViewHeaderModel?
    
    public func fetchStoryNews() {
        let request = APIRequest(endpoint: .science, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let storyModel):
                self?.delegate?.fetchStoryNews(storyModel.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
