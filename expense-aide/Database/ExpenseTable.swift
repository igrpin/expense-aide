//
//  ExpenseTable.swift
//  expense-aide
//
//  Created by Igor Pino de Souza on 03/02/23.
//

import Foundation
import SQLite


final class ExpenseTable {
    
    private var db: Connection!
    private let expense = Table("expense")
    private let id = Expression<Int64>("id")
    private let insertDate = Expression<Date>("insert_date")
    private let value = Expression<Double>("value")
    private let description = Expression<String?>("description")
    private let deleted = Expression<Bool>("deleted")
    
    init(_ db: Connection) {
        self.db = db
        do {
            try db.run(expense.create(ifNotExists: true) {
                t in
                t.column(id, primaryKey: .autoincrement)
                t.column(value)
                t.column(description)
                t.column(insertDate)
                t.column(deleted, defaultValue: false)
                print("Expense table created!")
            })} catch {
                print("Error: \(error.localizedDescription)")
            }
    }
    
    func add(entry: Expense) {
        do {
            try db.run(expense.insert(self.value <- entry.value, self.description <- entry.description, self.insertDate <- Date()))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(entry: Expense) {
        do {
            let query = expense.filter(id == entry.id)
            if try db.run(query.update(self.value <- entry.value, self.description <- entry.description, self.insertDate <- Date())) > 0 {
                print("Expense #\(entry.id) updated")
            } else {
                print("Expense #\(entry.id) not found")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(entry: Expense) {
        
    }
}
