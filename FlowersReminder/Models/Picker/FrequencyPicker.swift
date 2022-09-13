//
//  FrequencyPicker.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 13.09.2022.
//

import UIKit

extension UIViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
   
    func alertIrrigationFrequencyPicker(label:UILabel, complitionHamdler: @escaping (String)->Void){
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let picker = UIPickerView(frame: CGRect(x: 0, y: -20, width: 250, height: 250))
        
        picker.center.x = alert.view.center.x
        
        picker.tag = 1
        picker.delegate = self
        picker.dataSource = self
        
        alert.view.addSubview(picker)
        
        let ok = UIAlertAction(title: "OK", style: .default) {(action) in
            
            if picker.selectedRow(inComponent: 0) == 0{
                label.text = "Раз в 3 дня"
            }else if picker.selectedRow(inComponent: 0) == 1{
                label.text = "Раз в 5 дней"
            }else if picker.selectedRow(inComponent: 0) == 2{
                label.text = "Раз в неделю"
            }else if picker.selectedRow(inComponent: 0) == 3{
                label.text = "Раз в 2 недели"
            }else if picker.selectedRow(inComponent: 0) == 4{
                label.text = "Раз в месяц"
            }else if picker.selectedRow(inComponent: 0) == 5{
                label.text = "Раз в два месяца"
            }
        
            complitionHamdler(label.text!)
            
        }
        
        let cancel = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        present(alert, animated: true)
    }
    
    func alertFertilizerFrequencyPicker(label:UILabel, complitionHamdler: @escaping (String)->Void){
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let picker = UIPickerView(frame: CGRect(x: 0, y: -20, width: 250, height: 250))
       
        picker.center.x = alert.view.center.x
        picker.tag = 2
        picker.delegate = self
        picker.dataSource = self
        
        alert.view.addSubview(picker)
        
        let ok = UIAlertAction(title: "OK", style: .default) {(action) in
            
            if picker.selectedRow(inComponent: 0) == 0{
                label.text = "Раз в месяц"
            }else if picker.selectedRow(inComponent: 0) == 1{
                label.text = "Раз в 2 месяца"
            }
            
            complitionHamdler(label.text!)
            
        }
        
        let cancel = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        present(alert, animated: true)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1{
            return 6
        } else if pickerView.tag == 2{
            return 2
        }
        
        return 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
            let irrigationFrequencyPickerData = ["Раз в 3 дня",
                                                 "Раз в 5 дней",
                                                 "Раз в неделю",
                                                 "Раз в 2 недели",
                                                 "Раз в месяц",
                                                 "Раз в два месяца"
                                            ]
            return "\(irrigationFrequencyPickerData[row])"
        }else if pickerView.tag == 2{
            
            let fertilizerFrequencyPickerData = ["Раз в месяц",
                                                 "Раз в два месяца"]
            
            return "\(fertilizerFrequencyPickerData[row])"
        }
        
        return ""
    }
   
}

