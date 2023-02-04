//
//  ExpenseTable.swift
//  expense-aide
//
//  Created by Igor Pino de Souza on 03/02/23.
//

import Foundation
import SQLite


final class ExpenseTable {
    
    private let db: Connection!
    private let expenseTable = Table("expense")
    private let id = Expression<Int64>("id")
    private let insertDate = Expression<Date>("insert_date")
    private let value = Expression<Double>("value")
    private let description = Expression<String?>("description")
    private let deleted = Expression<Bool>("deleted")
    
    init(_ db: Connection) {
        self.db = db
        do {
            try self.db.run(expenseTable.create(ifNotExists: true) {
                t in
                t.column(id, primaryKey: .autoincrement)
                t.column(value)
                t.column(description)
                t.column(insertDate)
                t.column(deleted, defaultValue: false)
            })} catch {
                print("Error: \(error.localizedDescription)")
            }
    }
    
    func getAll() {
        do {
            let rowIterator = try db.prepareRowIterator(expenseTable)
            for row in try Array(rowIterator) {
                print("id: \(row[id]), value: \(row[value]), insert date: \(row[insertDate])")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getById(entry: Expense) {
        do {
            let query = expenseTable.filter(id == entry.id)
            for row in try db.prepare(query) {
                print("id: \(row[id]), value: \(row[value]), insert date: \(row[insertDate])")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(entry: Expense) {
        do {
            try db.run(expenseTable.insert(self.value <- entry.value, self.description <- entry.description, self.insertDate <- Date()))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(entry: Expense) {
        do {
            let query = expenseTable.filter(id == entry.id)
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
