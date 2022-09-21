//
//  FlowerCard.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 20.09.2022.
//

import UIKit
import RealmSwift

class FlowerCard: UICollectionViewController{
    
    var flowerModel = FlowerModel()
    let localRealm = try! Realm()
    
    private let flowerInfoCellID = "flowerInfoCellID"
    private let flowerCardHeaderID = "flowerCardHeaderID"
    private let flowerCardButtonsCell = "flowerCardButtonsCell"
    
    private var infoData: [String] = []
    private var pickerData: [String] = []
    
    private let padding: CGFloat = 16
    
    private var changeActivate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewConfig()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        infoData = [
            "\(dateFormatter.string(from: flowerModel.dateWatering))",
            "\(flowerModel.temperature)",
            "\(flowerModel.sun)",
            "\(irrigationFrequencyLabel())",
            "\(fertilizerFrequencyLabel())",
            "\(flowerModel.toxicityForAnimals)",
            
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
    
    //MARK: collectionViewConfig
    
    private func collectionViewConfig(){
        
        navigationController?.tabBarController?.tabBar.isHidden = true
        if #available(iOS 13.0, *) {
                            let navBarAppearance = UINavigationBarAppearance()
                            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = UIColor.clear
                    navBarAppearance.largeTitleTextAttributes = [
                        NSAttributedString.Key.foregroundColor : UIColor.clear
                    ]
                    navBarAppearance.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor : UIColor.clear
                    ]
                    navigationController?.navigationBar.standardAppearance = navBarAppearance
                    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.tintColor = UIColor.black
                        } else {
                            navigationController?.navigationBar.barTintColor = UIColor.clear
                        }
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = false
        
        collectionView.register(FlowerInfoCVCell.self, forCellWithReuseIdentifier: flowerInfoCellID)
        collectionView.register(FlowerCardButtonsCell.self, forCellWithReuseIdentifier: flowerCardButtonsCell)
        collectionView.register(FlowerCardHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: flowerCardHeaderID)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = .init(top: padding, left: 0, bottom: 100, right: padding)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoData.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flowerInfoCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: flowerInfoCellID, for: indexPath) as! FlowerInfoCVCell
        
        switch indexPath {
        case [0,0]:
            flowerInfoCVCell.cellConfig(indexPath: indexPath)
            flowerInfoCVCell.flowerInfo.text = infoData[indexPath.row]
            return flowerInfoCVCell
        case [0,1]:
            flowerInfoCVCell.cellConfig(indexPath: indexPath)
            flowerInfoCVCell.flowerInfo.text = infoData[indexPath.row]
            return flowerInfoCVCell
        case [0,2]:
            flowerInfoCVCell.cellConfig(indexPath: indexPath)
            flowerInfoCVCell.flowerInfo.text = infoData[indexPath.row]
            return flowerInfoCVCell
        case [0,3]:
            flowerInfoCVCell.cellConfig(indexPath: indexPath)
            flowerInfoCVCell.flowerInfo.text = infoData[indexPath.row]
            return flowerInfoCVCell
        case [0,4]:
            flowerInfoCVCell.cellConfig(indexPath: indexPath)
            flowerInfoCVCell.flowerInfo.text = infoData[indexPath.row]
            return flowerInfoCVCell
        case [0,5]:
            flowerInfoCVCell.cellConfig(indexPath: indexPath)
            flowerInfoCVCell.flowerInfo.text = infoData[indexPath.row]
            return flowerInfoCVCell
        case [0,6]:
            let flowerCardButtonsCell = collectionView.dequeueReusableCell(withReuseIdentifier: flowerCardButtonsCell, for: indexPath) as! FlowerCardButtonsCell
            flowerCardButtonsCell.cellConfig()
            
            flowerCardButtonsCell.buttonTapAction = { [self]
                ()  in
                changeActivate = !changeActivate
                collectionView.reloadData()
                collectionView.allowsSelection = changeActivate
                flowerCardButtonsCell.changeActivate = changeActivate
            }
            flowerCardButtonsCell.deleteButtonTapAction = { [self]
                () in
                
                deleteAlert(model: flowerModel)
            }
            
            return flowerCardButtonsCell
       
        default:
            flowerInfoCVCell.cellConfig(indexPath: indexPath)
            return flowerInfoCVCell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: flowerCardHeaderID, for: indexPath) as! FlowerCardHeader
        header.flowersImage.image = UIImage(data: flowerModel.flowerImage)
        header.flowerName.text = flowerModel.flowerName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        header.dateWatering.text = dateFormatter.string(from: flowerModel.dateWatering)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height / 2)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension FlowerCard: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let flowerInfoCVCell = collectionView.cellForItem(at: indexPath) as! FlowerInfoCVCell
        switch indexPath{
        case [0,0]:
            alertDatePicker(label: flowerInfoCVCell.flowerInfo) { [self] (date) in
                try! localRealm.write{
                    flowerModel.dateWatering = date
                    flowerModel.dateFertilizer = date
                    localRealm.add(flowerModel)
                }
            }
        case [0,1]:
            temperaturePicker(label: flowerInfoCVCell.flowerInfo) { [self] String in
                try! localRealm.write{
                    flowerModel.temperature = String
                    localRealm.add(flowerModel)
                }
            }
        case [0,2]:
            sunPicker(label: flowerInfoCVCell.flowerInfo) { [self] String in
                try! localRealm.write{
                    flowerModel.sun = String
                    localRealm.add(flowerModel)
                }
            }
        case [0,3]:
            alertIrrigationFrequencyPicker(label: flowerInfoCVCell.flowerInfo) { [self]  String in
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
        case [0,4]:
            alertFertilizerFrequencyPicker(label: flowerInfoCVCell.flowerInfo) { [self] String in
                try! localRealm.write{
                    if String == "Раз в месяц"{
                        flowerModel.fertilizerFrequency = 30
                    }else if String ==  "Раз в 2 месяца"{
                        flowerModel.fertilizerFrequency = 61
                    }
                    localRealm.add(flowerModel)
                }
            }
        case [0,5]:
            toxicityForAnimalsPicker(label: flowerInfoCVCell.flowerInfo) { [self] String in
                try! localRealm.write{
                    flowerModel.toxicityForAnimals = String
                    localRealm.add(flowerModel)
                }
            }
        default:
            print("Error")
        }
    }
}


