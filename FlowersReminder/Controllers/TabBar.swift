//
//  TabBar.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit

class TabBar: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private func createNavigationControllers(viewControllers: UIViewController, tabBarItemName: String, tabBarItemImage: String) -> UINavigationController{
        
        let tabBarItem = UITabBarItem(title: tabBarItemName, image: UIImage(systemName: tabBarItemImage), tag: 0)
        
        
        let navigationController = UINavigationController(rootViewController: viewControllers)
        
        return navigationController
    }
    
}
