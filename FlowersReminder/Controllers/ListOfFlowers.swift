//
//  ListOfFlowers.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit

class ListOfFlowers: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerConfig()
        
    }
    
    private func viewControllerConfig(){
        
        title = "Мои Цветы"
        view.backgroundColor = .white
    }
}
