//
//  ListOfFlowerCVCell.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 23.09.2022.
//

import UIKit

class ListOfFlowerCVCell: UICollectionViewCell {
    
    let shadowBackground: UIView = {
       let shadowBackground = UIView()
        shadowBackground.backgroundColor = .white
        shadowBackground.layer.cornerRadius = 15
        shadowBackground.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        shadowBackground.layer.shadowOpacity = 0.8
        shadowBackground.layer.shadowOffset = .zero
        shadowBackground.layer.shadowRadius = 5
        shadowBackground.clipsToBounds = false
        
        shadowBackground.translatesAutoresizingMaskIntoConstraints  = false
        return shadowBackground
    }()
   
    let flowerImage: UIImageView = {
       let flowerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        flowerImage.image = UIImage(named: "defaultFlower")
        flowerImage.contentMode = .scaleAspectFill
        flowerImage.layer.cornerRadius = 15
        flowerImage.clipsToBounds = true
        
        flowerImage.translatesAutoresizingMaskIntoConstraints = false
        return flowerImage
    }()
    
    let vStack: UIStackView = {
       let vStack = UIStackView()
        vStack.layer.zPosition = 3
        vStack.axis = .vertical
//        vStack.distribution = .fillEqually
        vStack.layer.cornerRadius = 15
        vStack.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    let flowerName: UILabel = {
       let flowerName = UILabel()
        flowerName.text = "Гербера"
        flowerName.font = UIFont(name: "DitaSweet", size: 20)
        flowerName.textColor = .white
        flowerName.adjustsFontSizeToFitWidth = true
        
        flowerName.translatesAutoresizingMaskIntoConstraints = false
        return flowerName
    }()
    
    let dateWatering: UILabel = {
       let dateWatering = UILabel()
        dateWatering.text = "09.09.2022"
        dateWatering.font = UIFont.systemFont(ofSize: 12)
        dateWatering.textColor = .white
        dateWatering.adjustsFontSizeToFitWidth = true
        dateWatering.translatesAutoresizingMaskIntoConstraints = false
        return dateWatering
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setConstraints()
        setGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(indexPath: IndexPath, model: FlowerModel){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        
        flowerName.text = model.flowerName
        dateWatering.text = dateFormatter.string(from: model.dateWatering)
        flowerImage.image = UIImage(data: model.flowerImage)
        
    }
    
    //MARK: setGradientLayer
    private func setGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.9).cgColor]
        gradient.locations = [0.5, 1]
        
        let gradientConteinerView = UIView()
            addSubview(gradientConteinerView)
        NSLayoutConstraint.activate([
            gradientConteinerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            gradientConteinerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            gradientConteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        gradientConteinerView.layer.addSublayer(gradient)
        gradientConteinerView.layer.cornerRadius = 15
        gradient.zPosition = 2
        gradient.cornerRadius = 15
        
        
        gradient.frame = self.bounds
        
    }
    
    //MARK: Set Constraints
    private func setConstraints(){
        
        self.addSubview(shadowBackground)
        NSLayoutConstraint.activate([
            shadowBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            shadowBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            shadowBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            shadowBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        self.addSubview(flowerImage)
        NSLayoutConstraint.activate([
            flowerImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            flowerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            flowerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            flowerImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        self.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            vStack.heightAnchor.constraint(equalToConstant: self.frame.width / 2.3),
            
        ])
        
        vStack.addSubview(flowerName)
        NSLayoutConstraint.activate([
            flowerName.topAnchor.constraint(equalTo: vStack.topAnchor, constant: 5),
            flowerName.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 10),
            flowerName.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -5),
            flowerName.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        vStack.addSubview(dateWatering)
        NSLayoutConstraint.activate([
            dateWatering.topAnchor.constraint(equalTo: flowerName.bottomAnchor, constant: 0),
            dateWatering.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 10),
            dateWatering.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -5),
        ])
        
    }
}
