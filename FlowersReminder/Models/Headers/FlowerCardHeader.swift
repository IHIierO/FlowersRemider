//
//  FlowerCardHeader.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 20.09.2022.
//

import UIKit
import RealmSwift

class FlowerCardHeader: UICollectionReusableView {
    
    var flowerModel = FlowerModel()
    let localRealm = try! Realm()
    
    let flowersImage: UIImageView = {
        let flowersImage = UIImageView()
        flowersImage.image = UIImage(named: "DSC01923")
        flowersImage.contentMode = .scaleAspectFill
        flowersImage.clipsToBounds = true
        flowersImage.translatesAutoresizingMaskIntoConstraints = false
        return flowersImage
    }()
    
    let vStack: UIStackView = {
       let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.backgroundColor = .white
        vStack.layer.cornerRadius = 10
        vStack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    let flowerName: UILabel = {
       let flowerName = UILabel()
        flowerName.text = "Гербера"
        flowerName.adjustsFontSizeToFitWidth = true
        flowerName.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        flowerName.textColor = UIColor(hexString: "#393C39")
        
        flowerName.translatesAutoresizingMaskIntoConstraints = false
        return flowerName
    }()
    
    let dateWatering: UILabel = {
       let dateWatering = UILabel()
        dateWatering.text = "09.09.2022"
        dateWatering.adjustsFontSizeToFitWidth = true
        dateWatering.font = UIFont.systemFont(ofSize: 16, weight: .light)
        dateWatering.textColor = UIColor(hexString: "#393C39").withAlphaComponent(0.8)
        dateWatering.translatesAutoresizingMaskIntoConstraints = false
        return dateWatering
    }()
    
    let rectangle: UIView = {
       let rectangle = UIView()
        rectangle.backgroundColor = .black.withAlphaComponent(0.3)
        rectangle.layer.cornerRadius = 2.5
        
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        return rectangle
    }()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setConstraints
    
    private func setConstraints(){
        addSubview(flowersImage)
        NSLayoutConstraint.activate([
            flowersImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            flowersImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            flowersImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            flowersImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
        
        addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.bottomAnchor.constraint(equalTo: flowersImage.bottomAnchor, constant: 0),
            vStack.leadingAnchor.constraint(equalTo: flowersImage.leadingAnchor, constant: 0),
            vStack.trailingAnchor.constraint(equalTo: flowersImage.trailingAnchor, constant: 0),
            vStack.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        vStack.addSubview(rectangle)
        NSLayoutConstraint.activate([
            rectangle.topAnchor.constraint(equalTo: vStack.topAnchor, constant: 4),
            rectangle.centerXAnchor.constraint(equalTo: vStack.centerXAnchor),
            rectangle.widthAnchor.constraint(equalToConstant: 30),
            rectangle.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        vStack.addSubview(flowerName)
        NSLayoutConstraint.activate([
            flowerName.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 5),
            flowerName.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 10),
            flowerName.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -5),
        ])
        
        vStack.addSubview(dateWatering)
        NSLayoutConstraint.activate([
            dateWatering.topAnchor.constraint(equalTo: flowerName.bottomAnchor, constant: 5),
            dateWatering.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 10),
            dateWatering.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -5),
            dateWatering.bottomAnchor.constraint(equalTo: vStack.bottomAnchor, constant: -2),
        ])
    }
    
}
