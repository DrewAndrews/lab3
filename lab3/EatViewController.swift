//
//  EatViewController.swift
//  lab3
//
//  Created by Andrey Rusinovich on 17.04.2022.
//

import UIKit
import SwiftyJSON

class EatViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foodTable: UITableView!
    @IBOutlet weak var portionField: UITextField!
    @IBOutlet weak var dateChoose: UIDatePicker!
    
    var currentFood: Food?
    var currentDate: Date?
    
    @IBAction func updateDate(_ sender: UIDatePicker) {
        currentDate = dateChoose.date
    }
    
    @IBAction func addPortions(_ sender: UIButton) {
        var portion = Portion()
        if portionField.text != "", let amount = portionField.text {
            portion.amount = Int(amount)!
        } else {
            let row = foodTable.indexPathForSelectedRow!.row
            let amount = food[row].dose
            portion.amount = amount
        }
        if let currentDate = currentDate {
            portion.date = currentDate
        }
        if let currentFood = currentFood {
            portion.food = currentFood
            Portion.portions.append(portion)
        }
    }
    
    var food = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFood()
        foodTable.delegate = self
        foodTable.dataSource = self
    }
    
    private func loadFood() {
        if let path = Bundle.main.path(forResource: "products", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let json = try JSON(data: data)
                food = json["products"].arrayValue.map { Food.mapSelf($0) }
            } catch {
                print("ERROR")
            }
        }
    }
}

extension EatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentFood = food[indexPath.row]
        print(food[indexPath.row])
    }
}

extension EatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myFoodId", for: indexPath)
        
        cell.textLabel?.text = food[indexPath.row].name
        
        return cell
    }
}
