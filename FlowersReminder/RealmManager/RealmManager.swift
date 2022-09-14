//
//  RealmManager.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 10.09.2022.
//

import RealmSwift

class RealmManager{
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveFlowerModel(model: FlowerModel){
        try! localRealm.write{
            localRealm.add(model)
        }
    }
    
    func updateCompliteColor(model: FlowerModel, hex: String){
        try! localRealm.write{
            model.compliteColor = hex
        }
    }
    
}
