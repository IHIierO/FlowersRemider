//
//  FlowerInfoCVCell.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 20.09.2022.
//

import UIKit

class FlowerInfoCVCell: UICollectionViewCell {
    
    let shadowBackground: UIView = {
       let shadowBackground = UIView()
        shadowBackground.backgroundColor = .white
        shadowBackground.layer.cornerRadius = 35
        shadowBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        shadowBackground.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        shadowBackground.layer.shadowOpacity = 0.8
        shadowBackground.layer.shadowOffset = .zero
        shadowBackground.layer.shadowRadius = 5
        shadowBackground.clipsToBounds = false
        
        shadowBackground.translatesAutoresizingMaskIntoConstraints  = false
        return shadowBackground
    }()
    
    let hStack: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        hStack.backgroundColor = UIColor(hexString: "#CFD9CE")
        hStack.layer.cornerRadius = 35
        hStack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    let iconImage: UIImageView = {
       let iconImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        iconImage.contentMode = .scaleAspectFill
        iconImage.tintColor = UIColor(hexString: "#3E413E")
        
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        return iconImage
    }()
    
    private var iconImageData = [
        "calendar.circle",
        "thermometer.sun.circle",
        "sun.max.circle",
        "drop.circle",
        "leaf.arrow.triangle.circlepath",
        "pawprint.circle",
    ]
    
    let flowerInfo: UILabel = {
       let flowerInfo = UILabel()
        flowerInfo.adjustsFontSizeToFitWidth = true
        flowerInfo.textColor = UIColor(hexString: "#393C39")
        
        flowerInfo.translatesAutoresizingMaskIntoConstraints = false
        return flowerInfo
    }()
    
    private var flowerInfoTextData = [
        "Выбери дату",
        "Тепло / Холод",
        "Солнце / Тень",
        "Выбери переодичность полива",
        "Выбери переодичность удобрения",
        "Токсичен / Не токсичен для животных",
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(indexPath: IndexPath){
        
        iconImage.image = UIImage(systemName: "\(iconImageData[indexPath.row])")
        flowerInfo.text = flowerInfoTextData[indexPath.row]
        
    }
    
    //MARK: Set Constraints
    
    private func setConstraints(){
        
        self.addSubview(shadowBackground)
        NSLayoutConstraint.activate([
            shadowBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            shadowBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            shadowBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            shadowBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        self.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        hStack.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: hStack.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: hStack.leadingAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalToConstant: 35),
            iconImage.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        hStack.addSubview(flowerInfo)
        NSLayoutConstraint.activate([
            flowerInfo.topAnchor.constraint(equalTo: hStack.topAnchor, constant: 10),
            flowerInfo.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 10),
            flowerInfo.trailingAnchor.constraint(equalTo: hStack.trailingAnchor, constant: -10),
            flowerInfo.bottomAnchor.constraint(equalTo: hStack.bottomAnchor, constant: -10),
        ])
        
    }
}

