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
    public let expenseTable: ExpenseTable!
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            db = try Connection("\(path)/db.sqlite3")
            print("Connected to database! PATH: \(path)")
        } catch {
            print(error.localizedDescription)
        }
        expenseTable = ExpenseTable(db)
    }

}
