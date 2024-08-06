//
//  RootViewController.swift
//  bookSercher
//
//  Created by 백시훈 on 8/2/24.
//

import Foundation
import UIKit
import SnapKit
class RootViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapBar()
    }
    
    func setupTapBar(){
        
        let tabBarController = UITabBarController()
        let searchViewController = SearchViewController()
        let shoppingBasketViewController = ShoppingBasketViewController()
        
        tabBarController.tabBar.tintColor = .orange
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        shoppingBasketViewController.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "cart"), tag: 1)
        
        tabBarController.viewControllers = [searchViewController, shoppingBasketViewController]
        
        
        addChild(tabBarController)
        self.view.addSubview(tabBarController.view)
        tabBarController.view.snp.makeConstraints {
            $0.edges.equalTo(self.view.snp.edges)
        }
        tabBarController.didMove(toParent: self)
    }
    
}
