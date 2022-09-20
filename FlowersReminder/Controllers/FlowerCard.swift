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
    
    private var infoData: [String] = []
    
    private let padding: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewConfig()
        
        infoData = [
            "\(flowerModel.temperature)",
            "\(flowerModel.sun)",
            "\(flowerModel.watering)",
            "\(flowerModel.fertilization)",
            "\(flowerModel.toxicityForAnimals)",
            
        ]
    }
    
    //MARK: collectionViewConfig
    
    private func collectionViewConfig(){
        
        navigationController?.tabBarController?.tabBar.backgroundColor = UIColor(hexString: "#CA587F")
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
        
        collectionView.register(FlowerInfoCVCell.self, forCellWithReuseIdentifier: flowerInfoCellID)
        collectionView.register(FlowerCardHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: flowerCardHeaderID)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = .init(top: padding, left: 0, bottom: 100, right: padding)
        }
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: flowerInfoCellID, for: indexPath) as! FlowerInfoCVCell
        cell.cellConfig(indexPath: indexPath)
        cell.flowerInfo.text = infoData[indexPath.row]
        return cell
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
    
    
}
