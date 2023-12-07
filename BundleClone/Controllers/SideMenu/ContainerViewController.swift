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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
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
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
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
                break // fix here
            case .news:
                self?.addItems(viewController: NewsViewController()) // fix here
            case .tech:
                self?.addItems(viewController: TechViewController())
            case .gaming:
                self?.addItems(viewController: GamingViewController())
            case .politics:
                self?.addItems(viewController: PoliticsViewController())
            case .finance:
                self?.addItems(viewController: FinanceViewController())
            case .lifestyle:
                self?.addItems(viewController: LifestyleViewController())
            case .science:
                self?.addItems(viewController: ScienceViewController())
            case .sports:
                self?.addItems(viewController: SportsViewController())
            case .cinema:
                self?.addItems(viewController: CinemaViewController())
            case .arts:
                self?.addItems(viewController: ArtsViewController())
            }
        }
    }
    
    func addItems(viewController: UIViewController) {
        let vc = viewController
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = viewController.title
    }
    
    func resetToHome() {
        menuVC.view.removeFromSuperview()
        menuVC.didMove(toParent: nil)
        homeVC.title = menuVC.title
    }
}
