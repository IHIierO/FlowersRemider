//
//  Alerts.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 10.09.2022.
//

import UIKit
import RealmSwift

extension UIViewController{
    
    func saveAlert(){
        
        let alert = UIAlertController(title: "Сохранено", message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) {(action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func deleteAlert(model: FlowerModel){
        
        let alert = UIAlertController(title: "Вы уверены?", message: "Это действие нельзя отменить", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ДА", style: .default) {(action) in
            self.navigationController?.popViewController(animated: true)
            let localRealm = try! Realm()
            try! localRealm.write{
                localRealm.delete(model)
            }
        }
        
        let cancel = UIAlertAction(title: "ОТМЕНА", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}



