//
//  ListOfFlowersCell.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 09.09.2022.
//

import UIKit

class ListOfFlowersCell: UITableViewCell {
    
    let hStack: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.backgroundColor = .lightGray
        hStack.layer.cornerRadius = 10
        hStack.layer.masksToBounds = true
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    let flowerImage: UIImageView = {
       let flowerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        flowerImage.image = UIImage(named: "defaultFlower")
        flowerImage.contentMode = .scaleAspectFill
        
        
        flowerImage.translatesAutoresizingMaskIntoConstraints = false
        return flowerImage
    }()
    
    let vStack: UIStackView = {
       let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.backgroundColor = .lightGray
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    let flowerName: UILabel = {
       let flowerName = UILabel()
        flowerName.text = "Гербера"
        flowerName.adjustsFontSizeToFitWidth = true
        
        flowerName.translatesAutoresizingMaskIntoConstraints = false
        return flowerName
    }()
    
    let dateWatering: UILabel = {
       let dateWatering = UILabel()
        dateWatering.text = "09.09.2022"
        dateWatering.adjustsFontSizeToFitWidth = true
        dateWatering.translatesAutoresizingMaskIntoConstraints = false
        return dateWatering
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(hexString: "#FBDDE7")
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    //MARK: Set Constraints
    
    private func setConstraints(){
        
        self.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
        
        hStack.addSubview(flowerImage)
        NSLayoutConstraint.activate([
            flowerImage.topAnchor.constraint(equalTo: hStack.topAnchor, constant: 0),
            flowerImage.bottomAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 0),
            flowerImage.leadingAnchor.constraint(equalTo: hStack.leadingAnchor, constant: 0),
            flowerImage.heightAnchor.constraint(equalToConstant: 80),
            flowerImage.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        hStack.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: hStack.topAnchor, constant: 0),
            vStack.bottomAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 0),
            vStack.leadingAnchor.constraint(equalTo: flowerImage.trailingAnchor, constant: 0),
            vStack.trailingAnchor.constraint(equalTo: hStack.trailingAnchor, constant: 0),
        ])
        
        vStack.addSubview(flowerName)
        NSLayoutConstraint.activate([
            flowerName.topAnchor.constraint(equalTo: vStack.topAnchor, constant: 5),
            flowerName.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 0),
            flowerName.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -5),
            flowerName.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        vStack.addSubview(dateWatering)
        NSLayoutConstraint.activate([
            dateWatering.topAnchor.constraint(equalTo: flowerName.bottomAnchor, constant: 5),
            dateWatering.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 0),
            dateWatering.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -5),
            dateWatering.bottomAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 0),
        ])
        
    }
}
