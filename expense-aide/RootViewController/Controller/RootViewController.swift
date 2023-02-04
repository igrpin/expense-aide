//
//  ViewController.swift
//  expense-aide
//
//  Created by Igor Pino de Souza on 31/01/23.
//

import UIKit

class RootViewController: UIViewController {
    let db = Database.shared
    let expense = Expense(value: 9, description: "", insertDate: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
//        db.expenseTable.add(entry: expense)
//        db.expenseTable.update(entry: expense)
        db.expenseTable.getById(entry: expense)
    }


}

