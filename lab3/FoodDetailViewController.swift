//
//  FoodDetailViewController.swift
//  lab3
//
//  Created by Andrey Rusinovich on 17.04.2022.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var kkalLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var belkiLabel: UILabel!
    @IBOutlet weak var jirLabel: UILabel!
    @IBOutlet weak var uglevLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    var food = Food()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = food.name
        typeLabel.text = "Категория продукта: \(food.type)"
        kkalLabel.text = "Калорийность(Ккал): \(food.kkal)"
        doseLabel.text = "Порция(г): \(food.dose)"
        belkiLabel.text = "Белки(г): \(food.proteins)"
        jirLabel.text = "Жиры(г): \(food.fats)"
        uglevLabel.text = "Углеводы(г): \(food.carbohydrates)"
        linkLabel.text = "Ссылка: \(food.link)"
    }
}
