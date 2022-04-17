//
//  Food.swift
//  lab3
//
//  Created by Andrey Rusinovich on 17.04.2022.
//

import Foundation
import SwiftyJSON

struct Food {
    var id: Int = 0
    var type: String = ""
    var name: String = ""
    var kkal: Int = 0
    var dose: Int = 0
    var proteins: Double = 0
    var fats: Double = 0
    var carbohydrates: Double = 0
    var link: String = ""
    
    static func mapSelf(_ json: JSON) -> Food {
        var food = Food()
        food.id = json["id"].intValue
        food.type = json["type"].stringValue
        food.name = json["name"].stringValue
        food.kkal = json["kkal"].intValue
        food.dose = json["dose"].intValue
        food.proteins = json["proteins"].doubleValue
        food.fats = json["fats"].doubleValue
        food.carbohydrates = json["carbohydrates"].doubleValue
        food.link = json["link"].stringValue
        return food
    }
}
