//
//  FlowerInfoCVCell.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 20.09.2022.
//

import UIKit

class FlowerInfoCVCell: UICollectionViewCell {
    
    
    let iconImage: UIImageView = {
       let iconImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        iconImage.contentMode = .scaleAspectFill
        
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        return iconImage
    }()
    
    private var iconImageData = ["thermometer.sun",
                                 "sun.max",
                                 "drop.fill",
                                 "leaf.arrow.triangle.circlepath",
                                 "pawprint.circle.fill",
                                 "thermometer.sun",
                                 "sun.max",
                                 "drop.fill",
    ]
    
    let flowerInfo: UILabel = {
       let flowerInfo = UILabel()
        flowerInfo.adjustsFontSizeToFitWidth = true
        
        flowerInfo.translatesAutoresizingMaskIntoConstraints = false
        return flowerInfo
    }()
    
    private var flowerInfoTextData = [
                                            "Тепло / Холод",
                                            "Солнце / Тень",
                                            "Сухость / Влажность",
                                            "Удобрение раз в месяц / 2 месяца",
                                            "Токсичен / Не токсичен для животных",
                                            "Тепло / Холод",
                                            "Солнце / Тень",
                                            "Сухость / Влажность",
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
        
        self.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalToConstant: 35),
            iconImage.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        self.addSubview(flowerInfo)
        NSLayoutConstraint.activate([
            flowerInfo.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            flowerInfo.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 10),
            flowerInfo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            flowerInfo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
    }
}

