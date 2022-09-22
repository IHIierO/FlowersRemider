//
//  FlowerCardOld.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit
import RealmSwift

class FlowerCardOld: UIViewController{
    
    var flowerModel = FlowerModel()
    let localRealm = try! Realm()
    
    let flowersImage: UIImageView = {
        let flowersImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        flowersImage.contentMode = .scaleAspectFill
        flowersImage.clipsToBounds = true
        flowersImage.translatesAutoresizingMaskIntoConstraints = false
        return flowersImage
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let flowerInfoCellId = "flowerInfoCellId"
    let pickerCellId = "pickerCellId"
    
    private var infoData: [String] = []
    
    private var pickerData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfig()
        setConstraints()
        
        infoData = [
            "\(flowerModel.temperature)",
            "\(flowerModel.sun)",
            "\(flowerModel.watering)",
            "\(flowerModel.fertilization)",
            "\(flowerModel.toxicityForAnimals)"
        ]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        pickerData = [
            "\(dateFormatter.string(from: flowerModel.dateWatering))",
            "\(irrigationFrequencyLabel())",
            "\(fertilizerFrequencyLabel())"
        ]
        
    }
    
    private func fertilizerFrequencyLabel() -> String{
        
        if flowerModel.fertilizerFrequency == 30{
            return "Раз в месяц"
        }else if flowerModel.fertilizerFrequency == 61{
            return "Раз в 2 месяца"
        }
        return "Выбери переодичность удобрения"
    }
    
    private func irrigationFrequencyLabel() -> String{
        
        if flowerModel.irrigationFrequency == 3{
            return "Раз в 3 дня"
        }else if flowerModel.irrigationFrequency == 5{
            return "Раз в 5 дней"
        }else if flowerModel.irrigationFrequency == 7{
            return "Раз в неделю"
        }else if flowerModel.irrigationFrequency == 14{
            return "Раз в 2 недели"
        }else if flowerModel.irrigationFrequency == 30{
            return "Раз в месяц"
        }else if flowerModel.irrigationFrequency == 61{
            return "Раз в два месяца"
        }
        return "Выбери переодичность полива"
    }
    
    private func viewControllerConfig(){
        title = "\(flowerModel.flowerName)"
        view.backgroundColor = UIColor(hexString: "#FBDDE7")
//        navigationController?.tabBarController?.tabBar.backgroundColor = UIColor(hexString: "#CA587F")
        
//        if #available(iOS 13.0, *) {
//                            let navBarAppearance = UINavigationBarAppearance()
//                            navBarAppearance.configureWithOpaqueBackground()
//                            navBarAppearance.backgroundColor = UIColor(hexString: "#CA587F")
//                    navBarAppearance.largeTitleTextAttributes = [
//                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
//                    ]
//                    navBarAppearance.titleTextAttributes = [
//                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
//                    ]
//                    navigationController?.navigationBar.standardAppearance = navBarAppearance
//                    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//                    navigationController?.navigationBar.tintColor = UIColor(hexString: "#ECFBDE")
//                        } else {
//                            navigationController?.navigationBar.barTintColor = UIColor(hexString: "#ECFBDE")
//                        }
        
        flowersImage.layer.borderWidth = 1
        flowersImage.layer.cornerRadius = 10
        flowersImage.image = UIImage(data: flowerModel.flowerImage)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hexString: "#FBDDE7")
        tableView.register(FlowerInfoCell.self, forCellReuseIdentifier: flowerInfoCellId)
        tableView.register(PickerCell.self, forCellReuseIdentifier: pickerCellId)
        tableView.separatorStyle = .none
        UITableViewHeaderFooterView.appearance().tintColor = .white
        
    }
    
    //MARK: setConstraints
    
    private func setConstraints(){
        view.addSubview(flowersImage)
        NSLayoutConstraint.activate([
            flowersImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            flowersImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            flowersImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            flowersImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: flowersImage.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension FlowerCardOld: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0: return "Информация"
        case 1: return "Дата"
            
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0 : return infoData.count
        case 1 : return pickerData.count
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath{
        case [0,0] :
            let cell = tableView.dequeueReusableCell(withIdentifier: flowerInfoCellId, for: indexPath) as! FlowerInfoCell
            cell.cellConfig(indexPath: indexPath)
            cell.flowerInfo.text = infoData[indexPath.row]
            return cell
        case [0,1] :
            let cell = tableView.dequeueReusableCell(withIdentifier: flowerInfoCellId, for: indexPath) as! FlowerInfoCell
            cell.cellConfig(indexPath: indexPath)
            cell.flowerInfo.text = infoData[indexPath.row]
            return cell
        case [0,2] :
            let cell = tableView.dequeueReusableCell(withIdentifier: flowerInfoCellId, for: indexPath) as! FlowerInfoCell
            cell.cellConfig(indexPath: indexPath)
            cell.flowerInfo.text = infoData[indexPath.row]
            return cell
        case [0,3] :
            let cell = tableView.dequeueReusableCell(withIdentifier: flowerInfoCellId, for: indexPath) as! FlowerInfoCell
            cell.cellConfig(indexPath: indexPath)
            cell.flowerInfo.text = infoData[indexPath.row]
            return cell
        case [0,4] :
            let cell = tableView.dequeueReusableCell(withIdentifier: flowerInfoCellId, for: indexPath) as! FlowerInfoCell
            cell.cellConfig(indexPath: indexPath)
            cell.flowerInfo.text = infoData[indexPath.row]
            return cell
        case [1,0] :
            let cell = tableView.dequeueReusableCell(withIdentifier: pickerCellId, for: indexPath) as! PickerCell
            cell.cellConfig(indexPath: indexPath)
            cell.dateInfo.text = pickerData[0]
            return cell
        case [1,1] :
            let cell = tableView.dequeueReusableCell(withIdentifier: pickerCellId, for: indexPath) as! PickerCell
            cell.cellConfig(indexPath: indexPath)
            cell.dateInfo.text = pickerData[1]
            return cell
        case [1,2] :
            let cell = tableView.dequeueReusableCell(withIdentifier: pickerCellId, for: indexPath) as! PickerCell
            cell.cellConfig(indexPath: indexPath)
            cell.dateInfo.text = pickerData[2]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: flowerInfoCellId, for: indexPath) as! FlowerInfoCell
            cell.cellConfig(indexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath{
        case [1,0]:
            let cell = tableView.cellForRow(at: indexPath) as! PickerCell
            alertDatePicker(label: cell.dateInfo) { [self] (date) in
                try! localRealm.write{
                    flowerModel.dateWatering = date
                    flowerModel.dateFertilizer = date
                    localRealm.add(flowerModel)
                }
            }
        case [1,1]:
            let cell = tableView.cellForRow(at: indexPath) as! PickerCell
            alertIrrigationFrequencyPicker(label: cell.dateInfo) { [self]  String in
                try! localRealm.write{
                    if String == "Раз в 3 дня"{
                        flowerModel.irrigationFrequency = 3
                    }else if String ==  "Раз в 5 дней"{
                        flowerModel.irrigationFrequency = 5
                    }else if String ==  "Раз в неделю"{
                        flowerModel.irrigationFrequency = 7
                    }else if String ==  "Раз в 2 недели"{
                        flowerModel.irrigationFrequency = 14
                    }else if String ==  "Раз в месяц"{
                        flowerModel.irrigationFrequency = 30
                    }else if String ==  "Раз в два месяца"{
                        flowerModel.irrigationFrequency = 61
                    }
                    localRealm.add(flowerModel)
                }
            }
        case [1,2]:
            let cell = tableView.cellForRow(at: indexPath) as! PickerCell
            alertFertilizerFrequencyPicker(label: cell.dateInfo) { [self] String in
                try! localRealm.write{
                    if String == "Раз в месяц"{
                        flowerModel.fertilizerFrequency = 30
                    }else if String ==  "Раз в 2 месяца"{
                        flowerModel.fertilizerFrequency = 61
                    }
                    localRealm.add(flowerModel)
                }
            }
        default:
            print("Error")
        }
    }
    
}
    
    
    
 
