//
//  TotalsViewController.swift
//  lab3
//
//  Created by Andrey Rusinovich on 17.04.2022.
//

import UIKit

class TotalsViewController: UIViewController {
    
    @IBOutlet weak var dateChoose: UIDatePicker!
    @IBOutlet weak var foodTable: UITableView!
    @IBOutlet weak var kkalLabel: UILabel!
    @IBOutlet weak var belkiLabel: UILabel!
    @IBOutlet weak var jirLabel: UILabel!
    @IBOutlet weak var uglevLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        currentDate = dateChoose.date
        foodTable.reloadData()
        print(Portion.portions.filter { Calendar.current.isDate(currentDate!, equalTo: $0.date, toGranularity: .day) })
    }
    
    var currentDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTable.dataSource = self
        currentDate = dateChoose.date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        foodTable.reloadData()
    }
    
    private func makeEmpty() {
        kkalLabel.text = "Калорийность(Ккал): Нет данных"
        sumLabel.text = "Общий вес(г): Нет данных"
        belkiLabel.text = "Белки(г): Нет данных"
        jirLabel.text = "Жиры(г): Нет данных"
        uglevLabel.text = "Углеводы(г): Нет данных"
    }
    
    private func fillData() {
        let portions = Portion.portions.filter { Calendar.current.isDate(currentDate!, equalTo: $0.date, toGranularity: .day) }
        let kkal = portions.map { $0.food.kkal }.reduce(0, +)
        let belki = portions.map { $0.food.proteins }.reduce(0, +)
        let jiry = portions.map { $0.food.fats }.reduce(0, +)
        let uglev = portions.map { $0.food.carbohydrates }.reduce(0, +)
        let amount = portions.map { $0.amount }.reduce(0, +)
        
        kkalLabel.text = "Калорийность(Ккал): \(kkal)"
        sumLabel.text = "Общий вес(г): \(amount)"
        belkiLabel.text = "Белки(г): \(belki)"
        jirLabel.text = "Жиры(г): \(jiry)"
        uglevLabel.text = "Углеводы(г): \(uglev)"
    }
}

extension TotalsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let portions = Portion.portions.filter { Calendar.current.isDate(currentDate!, equalTo: $0.date, toGranularity: .day) }
        if portions.count == 0 {
            makeEmpty()
        } else {
            fillData()
        }
        return portions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "portionId", for: indexPath)
        cell.textLabel?.text = Portion.portions[indexPath.row].food.name
        
        return cell
    }
}
