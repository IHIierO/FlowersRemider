//
//  PickerCell.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 09.09.2022.
//

import UIKit

class PickerCell: UITableViewCell {
    
    let dateLabel: UILabel = {
       let dateLabel = UILabel()
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 2
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private var dateLabelData = [
        "Дата полива",
        "Переодичность полива",
        "Переодичность удобрения"
    ]
    
    let dateInfo: UILabel = {
       let dateInfo = UILabel()
        dateInfo.adjustsFontSizeToFitWidth = true
        dateInfo.textAlignment = .center
        
        dateInfo.translatesAutoresizingMaskIntoConstraints = false
        return dateInfo
    }()
    
    private var dateInfoData = [
                                            "Выбери дату",
                                            "Выбери переодичность полива",
                                            "Выбери переодичность удобрения"
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(hexString: "#FBDDE7")
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(indexPath: IndexPath){
        
        dateLabel.text = dateLabelData[indexPath.row]
        dateInfo.text = dateInfoData[indexPath.row]
        
    }
    
    //MARK: Set Constraints
    
    private func setConstraints(){
        
        self.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 60),
            dateLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        self.addSubview(dateInfo)
        NSLayoutConstraint.activate([
            dateInfo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateInfo.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 40),
            dateInfo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
    }
}

