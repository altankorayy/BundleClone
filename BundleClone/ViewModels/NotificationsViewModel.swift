//
//  NotificationsViewModel.swift
//  BundleClone
//
//  Created by Altan on 12.11.2023.
//

import Foundation

protocol NotificationsModelPass: AnyObject {
    func notificationsModel(_ model: [Article])
}

class NotificationsViewModel {
    
    weak var delegate: NotificationsModelPass?
    
    public func fetchNotifications() {
        let request = APIRequest(endpoint: .notifications)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.notificationsModel(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
