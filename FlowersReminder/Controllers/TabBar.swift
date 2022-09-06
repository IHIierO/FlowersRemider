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
        let ActiveAlarmViewController = createNavigationControllers(viewControllers: ActiveAlarms(), tabBarItemName: "Будильники", tabBarItemImage: "alarm.fill")
        
        viewControllers = [listOfFlowersViewController, ActiveAlarmViewController]
        
        self.tabBar.tintColor = UIColor(hexString: "#92CD5A")
        self.tabBar.unselectedItemTintColor = UIColor(hexString: "#ECFBDE")
        
    }
    
    private func createNavigationControllers(viewControllers: UIViewController, tabBarItemName: String, tabBarItemImage: String) -> UINavigationController{
        
        let tabBarItem = UITabBarItem(title: tabBarItemName, image: UIImage(systemName: tabBarItemImage), tag: 0)
        
        
        let navigationController = UINavigationController(rootViewController: viewControllers)
        navigationController.tabBarItem = tabBarItem
        
        
        return navigationController
    }
    
}
