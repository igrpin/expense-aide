//
//  DBHelper.swift
//  expense-aide
//
//  Created by Igor Pino de Souza on 31/01/23.
//

import Foundation
import SQLite

class Database {
    
    public static let shared = Database()
    private var db: Connection!
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            db = try Connection("\(path)/db.sqlite3")
            createTableExpense()
            print("Connected to database! PATH: \(path)")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func createTableExpense() {
        let expense = Table("expense")
        let id = Expression<Int64>("id")
        let insertDate = Expression<Date>("insert_date")
        let value = Expression<Double>("value")
        let description = Expression<String?>("description")
        let deleted = Expression<Bool>("deleted")
        
        do {
            try db.run(expense.create(ifNotExists: true) {
                t in
                t.column(id, primaryKey: true)
                t.column(insertDate)
                t.column(value)
                t.column(description)
                t.column(deleted, defaultValue: false)
            })} catch {
                print("Error: \(error.localizedDescription)")
            }
    }
}
