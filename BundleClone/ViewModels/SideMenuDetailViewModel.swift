//
//  SideMenuDetailViewModel.swift
//  BundleClone
//
//  Created by Altan on 9.12.2023.
//

import Foundation

protocol SideMenuModelDelegate: AnyObject {
    func sideMenuFinance(_ model: [Article])
    func sideMenuSports(_ model: [Article])
    func sideMenuGaming(_ model: [Article])
    func sideMenuTech(_ model: [Article])
    func sideMenuPolitics(_ model: [Article])
    func sideMenuLifestyle(_ model: [Article])
    func sideMenuScience(_ model: [Article])
    func sideMenuCinema(_ model: [Article])
    func sideMenuArts(_ model: [Article])
    func sideMenuTopHeadlines(_ model: [Article])
}

class SideMenuDetailViewModel {
    
    weak var delegate: SideMenuModelDelegate?
    
    //MARK: -Business & Finance
    public func fetchFinanceNews() {
        
        let request = APIRequest(endpoint: .notifications, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuFinance(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Sports
    public func fetchSportsNews() {
        
        let request = APIRequest(endpoint: .sports, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuSports(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Gaming & Geek
    public func fetchGamingNews() {
        
        let request = APIRequest(endpoint: .gaming, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuGaming(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Technology
    public func fetchTechNews() {
        
        let request = APIRequest(endpoint: .tech, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuTech(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Politics
    public func fetchPoliticsNews() {
        
        let request = APIRequest(endpoint: .politics, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuPolitics(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Lifestyle
    public func fetchLifestyleNews() {
        
        let request = APIRequest(endpoint: .lifestyle, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuLifestyle(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Science
    public func fetchScienceNews() {
        
        let request = APIRequest(endpoint: .science, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuScience(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Cinema
    public func fetchCinemaNews() {
        
        let request = APIRequest(endpoint: .cinema, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuCinema(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Arts
    public func fetchArtsNews() {
        
        let request = APIRequest(endpoint: .arts, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuArts(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -Top Headlines
    public func fetchTopHeadlinesNews() {
        
        let request = APIRequest(endpoint: .topHeadlines, query: nil)
        
        APIService.shared.execute(request, expecting: NewsModelResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.sideMenuTopHeadlines(model.articles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
