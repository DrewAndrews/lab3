//
//  Portion.swift
//  lab3
//
//  Created by Andrey Rusinovich on 18.04.2022.
//

import Foundation

struct Portion {
    var date: Date = Date()
    var food: Food = Food()
    var amount: Int = 0
    
    static var portions: [Portion] = []
}
