//
//  ContainerViewController.swift
//  BundleClone
//
//  Created by Altan on 27.11.2023.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    
    private let sideMenuViewModel = SideMenuDetailViewModel()
    
    private var artsModel: [Article] = []
    private var techModel: [Article] = []
    private var cinemaModel: [Article] = []
    private var gamingModel: [Article] = []
    private var sportsModel: [Article] = []
    private var financeModel: [Article] = []
    private var scienceModel: [Article] = []
    private var politicsModel: [Article] = []
    private var fashionModel: [Article] = []
    private var topHeadlinesModel: [Article] = []
    
    var selectedTitle: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.setColor(lightColor: .white, darkColor: UIColor.bundleColor)
        
        sideMenuViewModel.fetchArtsNews()
        sideMenuViewModel.fetchTechNews()
        sideMenuViewModel.fetchCinemaNews()
        sideMenuViewModel.fetchGamingNews()
        sideMenuViewModel.fetchSportsNews()
        sideMenuViewModel.fetchFinanceNews()
        sideMenuViewModel.fetchScienceNews()
        sideMenuViewModel.fetchPoliticsNews()
        sideMenuViewModel.fetchFashionNews()
        sideMenuViewModel.fetchTopHeadlinesNews()
        
        sideMenuViewModel.delegate = self
        
        addChildVCs()
    }

    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didSelectMenu() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            let headerView = MenuHeaderView()
            headerView.hiddenState(with: true)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - (UIDevice.isiPhone ? 100 : 500)
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            let headerView = MenuHeaderView()
            headerView.hiddenState(with: false)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        
        toggleMenu { [weak self] in
            switch menuItem {
            case .all:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.topHeadlinesModel ?? []), title: "ALL")
            case .tech:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.techModel ?? []), title: "TECHNOLOGY")
            case .gaming:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.gamingModel ?? []), title: "GAMING & GEEK")
            case .politics:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.politicsModel ?? []), title: "POLITICS")
            case .finance:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.financeModel ?? []), title: "BUSSINESS & FINANCE")
            case .fashion:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.fashionModel ?? []), title: "FASHION")
            case .science:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.scienceModel ?? []), title: "SCINCE")
            case .sports:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.sportsModel ?? []), title: "SPORTS")
            case .cinema:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.cinemaModel ?? []), title: "CINEMA")
            case .arts:
                self?.addItems(viewController: SideMenuDetailViewController(model: self?.artsModel ?? []), title: "ARTS & CULTURE")
            }
        }
    }
    
    func addItems(viewController: UIViewController, title: String) {
        let vc = viewController
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = title
    }
}

extension ContainerViewController: SideMenuModelDelegate {
    func sideMenuTopHeadlines(_ model: [Article]) {
        self.topHeadlinesModel = model
    }
    
    func sideMenuFinance(_ model: [Article]) {
        self.financeModel = model
    }
    
    func sideMenuSports(_ model: [Article]) {
        self.sportsModel = model
    }
    
    func sideMenuGaming(_ model: [Article]) {
        self.gamingModel = model
    }
    
    func sideMenuTech(_ model: [Article]) {
        self.techModel = model
    }
    
    func sideMenuPolitics(_ model: [Article]) {
        self.politicsModel = model
    }
    
    func sideMenuFashion(_ model: [Article]) {
        self.fashionModel = model
    }
    
    func sideMenuScience(_ model: [Article]) {
        self.scienceModel = model
    }
    
    func sideMenuCinema(_ model: [Article]) {
        self.cinemaModel = model
    }
    
    func sideMenuArts(_ model: [Article]) {
        self.artsModel = model
    }
}
