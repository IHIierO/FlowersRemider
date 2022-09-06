//
//  ActiveAlarms.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class ActiveAlarms: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfig()
        
    }
    
    private func viewControllerConfig(){
        title = "Будильники"
        view.backgroundColor = UIColor(hexString: "#FBDDE7")
        navigationController?.tabBarController?.tabBar.backgroundColor = UIColor(hexString: "#CA587F")
        
        if #available(iOS 13.0, *) {
                            let navBarAppearance = UINavigationBarAppearance()
                            navBarAppearance.configureWithOpaqueBackground()
                            navBarAppearance.backgroundColor = UIColor(hexString: "#CA587F")
                    navBarAppearance.largeTitleTextAttributes = [
                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
                    ]
                    navBarAppearance.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
                    ]
                    navigationController?.navigationBar.standardAppearance = navBarAppearance
                    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                    navigationController?.navigationBar.tintColor = UIColor(hexString: "#ECFBDE")
                        } else {
                            navigationController?.navigationBar.barTintColor = UIColor(hexString: "#ECFBDE")
                        }
    }
}
