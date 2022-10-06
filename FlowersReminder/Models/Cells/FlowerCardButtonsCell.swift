//
//  FlowerCardButtonsCell.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 21.09.2022.
//

import UIKit

class FlowerCardButtonsCell: UICollectionViewCell {
    
    var changeActivate = false
    
    var changeButtonTapAction : (()->())?
    var saveButtonTapAction : (()->())?
    var deleteButtonTapAction : (()->())?
    
    let shadowBackgroundForCangeButton: UIView = {
       let shadowBackground = UIView()
        shadowBackground.backgroundColor = .white
        shadowBackground.layer.cornerRadius = 35
        shadowBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        shadowBackground.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        shadowBackground.layer.shadowOpacity = 0.8
        shadowBackground.layer.shadowOffset = .zero
        shadowBackground.layer.shadowRadius = 5
        shadowBackground.clipsToBounds = false
        shadowBackground.tag = 1
        
        shadowBackground.translatesAutoresizingMaskIntoConstraints  = false
        return shadowBackground
    }()
    
    let shadowBackgroundForSaveButton: UIView = {
       let shadowBackground = UIView()
        shadowBackground.backgroundColor = .white
        shadowBackground.layer.cornerRadius = 35
        shadowBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        shadowBackground.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        shadowBackground.layer.shadowOpacity = 0.8
        shadowBackground.layer.shadowOffset = .zero
        shadowBackground.layer.shadowRadius = 5
        shadowBackground.clipsToBounds = false
        shadowBackground.tag = 3
        
        shadowBackground.translatesAutoresizingMaskIntoConstraints  = false
        return shadowBackground
    }()
    
    let shadowBackgroundForDeleteButton: UIView = {
       let shadowBackground = UIView()
        shadowBackground.backgroundColor = .white
        shadowBackground.layer.cornerRadius = 35
        shadowBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        shadowBackground.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        shadowBackground.layer.shadowOpacity = 0.8
        shadowBackground.layer.shadowOffset = .zero
        shadowBackground.layer.shadowRadius = 5
        shadowBackground.clipsToBounds = false
        shadowBackground.tag = 5
        
        shadowBackground.translatesAutoresizingMaskIntoConstraints  = false
        return shadowBackground
    }()
    
    let changeButton: UIButton = {
       let changeButton = UIButton()
        changeButton.setTitle("Изменить", for: .normal)
        changeButton.setTitleColor(UIColor(hexString: "#393C39"), for: .normal)
        changeButton.backgroundColor = UIColor(hexString: "#CFD9CE")
        changeButton.layer.cornerRadius = 35
        changeButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.tag = 2
        return changeButton
    }()
    
    let saveButton: UIButton = {
       let saveButton = UIButton()
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(UIColor(hexString: "#393C39"), for: .normal)
        saveButton.backgroundColor = UIColor(hexString: "#CFD9CE")
        saveButton.layer.cornerRadius = 35
        saveButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.tag = 4
        return saveButton
    }()
    
    let deleteButton: UIButton = {
       let deleteButton = UIButton()
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(UIColor(hexString: "#393C39"), for: .normal)
        deleteButton.backgroundColor = UIColor(hexString: "#CFD9CE")
        deleteButton.layer.cornerRadius = 35
        deleteButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.tag = 6
        return deleteButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
        
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeButtonTapped(){
        changeButtonTapAction?()
    }
    
    @objc func saveButtonTapped(){
        saveButtonTapAction?()
    }
    
    @objc func deleteButtonTapped(){
        deleteButtonTapAction?()
    }
    
//    internal func cellConfig(){
//
//        if changeActivate == false{
//
//            setConstraints()
//        }else{
//
//            setConstraints1()
//        }
//    }
    
    //MARK: setConstraints
    func setConstraints(){
        
        if let remove3 = viewWithTag(3){
            remove3.removeFromSuperview()
        }
        if let remove4 = viewWithTag(4){
            remove4.removeFromSuperview()
        }
        if let remove5 = viewWithTag(5){
            remove5.removeFromSuperview()
        }
        if let remove6 = viewWithTag(6){
            remove6.removeFromSuperview()
        }
        
        
        self.addSubview(shadowBackgroundForCangeButton)
        NSLayoutConstraint.activate([
            shadowBackgroundForCangeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            shadowBackgroundForCangeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
            shadowBackgroundForCangeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 26),
            shadowBackgroundForCangeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        self.addSubview(changeButton)
        NSLayoutConstraint.activate([
            changeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            changeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
            changeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 26),
            changeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
    }
    
    func setConstraints1(){
        
        if let remove1 = viewWithTag(1){
            remove1.removeFromSuperview()
        }
        if let remove2 = viewWithTag(2){
            remove2.removeFromSuperview()
        }
        
        self.addSubview(shadowBackgroundForSaveButton)
        
        NSLayoutConstraint.activate([
            shadowBackgroundForSaveButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            shadowBackgroundForSaveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 26),
            shadowBackgroundForSaveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            shadowBackgroundForSaveButton.widthAnchor.constraint(equalToConstant: self.frame.width / 2)
        ])
        
        self.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 26),
            saveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            saveButton.widthAnchor.constraint(equalToConstant: self.frame.width / 2)
        ])
        
        self.addSubview(shadowBackgroundForDeleteButton)
        NSLayoutConstraint.activate([
            shadowBackgroundForDeleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            shadowBackgroundForDeleteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            shadowBackgroundForDeleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            shadowBackgroundForDeleteButton.widthAnchor.constraint(equalToConstant: self.frame.width / 2)
        ])
        
        self.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            deleteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            deleteButton.widthAnchor.constraint(equalToConstant: self.frame.width / 2)
        ])
        
    }
    
}
