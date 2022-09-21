//
//  ActiveAlarmsCell.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 07.09.2022.
//

import UIKit

class ActiveAlarmsCell: UITableViewCell {
    
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
        flowerName.adjustsFontSizeToFitWidth = true
        
        flowerName.translatesAutoresizingMaskIntoConstraints = false
        return flowerName
    }()
    
    let flowerStatus: UILabel = {
       let flowerStatus = UILabel()
        flowerStatus.adjustsFontSizeToFitWidth = true
        flowerStatus.translatesAutoresizingMaskIntoConstraints = false
        return flowerStatus
    }()
    
    let compliteButton: UIButton = {
       let compliteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        compliteButton.setImage(UIImage(named: "complite"), for: .normal)
        
        compliteButton.translatesAutoresizingMaskIntoConstraints = false
        return compliteButton
    }()
    
    weak var activeAlarmsCellDelegate: TapButtonProtocol?
    var indexPath: IndexPath?
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(hexString: "#FBDDE7")
        setConstraints()
        self.selectionStyle = .none
        compliteButton.addTarget(self, action: #selector(compliteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func compliteButtonTapped(){
        guard let indexPath = indexPath else {return}
        activeAlarmsCellDelegate?.buttonTapped(indexPath: indexPath)
    }
    
    func cellConfig(indexPath: IndexPath, model: FlowerModel,date: Date){
        flowerImage.image = UIImage(data: model.flowerImage)
        flowerName.text = model.flowerName
        flowerName.textColor = UIColor(hexString: "\(model.compliteColor)")
        flowerStatus.textColor = UIColor(hexString: "\(model.compliteColor)")
        
        if Calendar.current.isDate(model.dateWatering, equalTo: date, toGranularity: .day){
            flowerStatus.text = "Cегодня только полить"
        }
        if Calendar.current.isDate(model.dateFertilizer, equalTo: date, toGranularity: .day) {
            flowerStatus.text = "Cегодня только удобрить"
        }
        if Calendar.current.isDate(model.dateWatering, equalTo: model.dateFertilizer, toGranularity: .day){
            flowerStatus.text = "Cегодня полить и удобрить"
        }
        
    }
    
    //MARK: Set Constraints
    
    private func setConstraints(){
        
        self.contentView.addSubview(compliteButton)
        NSLayoutConstraint.activate([
            compliteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            compliteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            compliteButton.heightAnchor.constraint(equalToConstant: 40),
            compliteButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: compliteButton.leadingAnchor, constant: -10),
        ])
        
        hStack.addSubview(flowerImage)
        NSLayoutConstraint.activate([
            flowerImage.topAnchor.constraint(equalTo: hStack.topAnchor, constant: 0),
            flowerImage.bottomAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 0),
            flowerImage.leadingAnchor.constraint(equalTo: hStack.leadingAnchor, constant: 0),
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
            flowerName.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 10),
            flowerName.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -5),
            flowerName.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        vStack.addSubview(flowerStatus)
        NSLayoutConstraint.activate([
            flowerStatus.topAnchor.constraint(equalTo: flowerName.bottomAnchor, constant: 5),
            flowerStatus.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 10),
            flowerStatus.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -5),
            flowerStatus.bottomAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 0),
        ])
        
    }

}
