//
//  MenuViewController.swift
//  lab3
//
//  Created by Andrey Rusinovich on 17.04.2022.
//

import UIKit
import SwiftyJSON

class MenuViewController: UITableViewController {
    
    var food: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFood()
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
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return food.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodId", for: indexPath)
        
        cell.textLabel?.text = food[indexPath.row].name
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            food.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails",
           let vc = segue.destination as? FoodDetailViewController,
           let row = tableView.indexPathForSelectedRow?.row {
            let detail = food[row]
            vc.food = detail
        }
    }
}
