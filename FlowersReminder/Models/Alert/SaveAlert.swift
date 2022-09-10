//
//  SaveAlert.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 10.09.2022.
//

import UIKit

extension UIViewController{
    
    func saveAlert(){
        
        let alert = UIAlertController(title: "Сохранено", message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) {(action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}



