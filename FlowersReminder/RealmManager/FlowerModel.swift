//
//  FlowerModel.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 09.09.2022.
//

import UIKit
import RealmSwift


class FlowerModel: Object, Identifiable {
    
    @Persisted var id = UUID()
    @Persisted var flowerName = ""
    @Persisted var flowerImage = Data()
    @Persisted var temperature = ""
    @Persisted var sun = ""
    @Persisted var watering = ""
    @Persisted var fertilization = ""
    @Persisted var toxicityForAnimals = ""
    @Persisted var dateWatering = Date()
    @Persisted var dateFertilizer = Date()
    @Persisted var irrigationFrequency: Int?
    @Persisted var fertilizerFrequency: Int?
    @Persisted var compliteColor = "#000000"
}
