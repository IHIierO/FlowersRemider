//
//  AddNewFlowerCell.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 09.09.2022.
//

import UIKit

class AddNewFlowerCell: UITableViewCell {
    
    var callback: ((String) ->())?
    
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
                                 "pawprint.circle.fill"]
    
    let flowerInfo: UITextField = {
       let flowerInfo = UITextField()
        flowerInfo.adjustsFontSizeToFitWidth = true
        flowerInfo.borderStyle = .roundedRect
        
        flowerInfo.translatesAutoresizingMaskIntoConstraints = false
        return flowerInfo
    }()
    
    private var flowerInfoPlaceholderData = [
                                            "Тепло / Холод",
                                            "Солнце / Тень",
                                            "Сухость / Влажность",
                                            "Удобрение раз в месяц / 2 месяца",
                                            "Токсичен / Не токсичен для животных"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(hexString: "#FBDDE7")
        setConstraints()
        
        flowerInfo.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldChanged(_ textField: UITextField) -> Void {
        callback?(textField.text ?? "")
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(indexPath: IndexPath){
        
        iconImage.image = UIImage(systemName: "\(iconImageData[indexPath.row])")
        flowerInfo.placeholder = "\(flowerInfoPlaceholderData[indexPath.row])"
        
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

