//
//  ExpenseModel.swift
//  expense-aide
//
//  Created by Igor Pino de Souza on 03/02/23.
//

import Foundation

struct Expense: Identifiable {
    var id: Int64
    var insertDate: Date
    var value: Double
    var description: String
    var deleted: Bool
    
    init(value: Double, description: String, insertDate: Date) {
        self.id = 0
        self.insertDate = insertDate
        self.value = value
        self.description = description
        self.deleted = false
    }
}
