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
        
        tabBarConfig()
    }
    
    private func tabBarConfig(){
        
        let listOfFlowersViewController = createNavigationControllers(viewControllers: ListOfFlowers(), tabBarItemName: "Мои Цветы", tabBarItemImage: "camera.macro")
        let activeAlarmViewController = createNavigationControllers(viewControllers: ActiveAlarms(), tabBarItemName: "Будильники", tabBarItemImage: "alarm.fill")
        
        viewControllers = [listOfFlowersViewController, activeAlarmViewController]
        
        self.tabBar.tintColor = UIColor(hexString: "#92CD5A")
        self.tabBar.unselectedItemTintColor = UIColor(hexString: "#ECFBDE")
        
    }
    
    private func createNavigationControllers(viewControllers: UIViewController, tabBarItemName: String, tabBarItemImage: String) -> UINavigationController{
        
        let tabBarItem = UITabBarItem(title: tabBarItemName, image: UIImage(systemName: tabBarItemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10 )
        
        
        let navigationController = UINavigationController(rootViewController: viewControllers)
        navigationController.tabBarItem = tabBarItem
        
        
        return navigationController
    }
    
}
