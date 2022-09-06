//
//  ActiveAlarms.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit

class ActiveAlarms: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfig()
        
    }
    
    private func viewControllerConfig(){
        title = "Будильники"
        view.backgroundColor = .white
    }
}
