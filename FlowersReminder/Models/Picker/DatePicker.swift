//
//  DatePicker.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 09.09.2022.
//

import UIKit

extension UIViewController{
    
    func alertDatePicker(label:UILabel, complitionHamdler: @escaping (Date)->Void){
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "OK", style: .default) {(action) in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            let date = datePicker.date
            complitionHamdler(date)
            
            label.text = dateString
        
        }
        
        let cancel = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        present(alert, animated: true)
    }
    
}
