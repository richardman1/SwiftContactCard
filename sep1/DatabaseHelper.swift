//
//  DatabaseHelper.swift
//  sep1
//
//  Created by Ricardo Jobse on 10/20/16.
//  Copyright © 2016 Richard de Jongh. All rights reserved.
//


import Foundation


class DataBaseHelper: NSObject {
    
    static let sharedInstance = DataBaseHelper()
    
    var db : OpaquePointer? = nil
    
    
    override init() {
        
        super.init();
        
        //
        let bundlePathUrl = Bundle.main.url(forResource: "ContactCard", withExtension: "db")
        let docPathUrl = getDocumentsDirectory().appendingPathComponent("ContactCard.db")
        
        // Copy db file als deze niet bestaat
        if !FileManager.default.fileExists(atPath: docPathUrl.path) {
            try! FileManager.default.copyItem(at: bundlePathUrl!, to: docPathUrl)
        }
        
        // Open vanaf de document directory de db
        if sqlite3_open(docPathUrl.path, &db) != SQLITE_OK {
            print("Error opening database!!")
        } else {
            print("Database succesfully opened!!")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0];
    }
    
    // CREATE from CRUD
    func create(firstname: String, lastname: String, imageUrl:String, email:String, address:String, city:String,
                state:String, phone:String, cell:String) {
        
        let query = "INSERT INTO person (FirstName, LastName, ImageUrl, Email, Address, City, State, Phone, Cell) VALUES (?, ?,?,?,?,?,?,?,?)"
        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, firstname, -1, nil);
            sqlite3_bind_text(statement, 2, lastname, -1, nil);
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error inserting row")
            }
        } else {
            print("Error")
        }
        
        // Reset als je insert in een loop
        sqlite3_reset(statement);
        //
        sqlite3_finalize(statement);
    }
    
    // READ from CRUD
    func read() -> [Person] {
        
        // Empty array
        var result = [Person]();
        
        // Query
        let query = "SELECT * FROM Person;"
        
        // Prepare query and execute
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error query: \(errmsg)")
            return result
        }
        
        // Construct model
        while sqlite3_step(statement) == SQLITE_ROW {
            let person = Person();
            person.firstName = String(cString: sqlite3_column_text(statement, 1));
            person.lastName = String(cString: sqlite3_column_text(statement, 2));
            person.image = String(cString: sqlite3_column_text(statement, 3));
            person.email = String(cString: sqlite3_column_text(statement, 4));
            person.street = String(cString: sqlite3_column_text(statement, 5));
            person.city = String(cString: sqlite3_column_text(statement, 6));
            person.state = String(cString: sqlite3_column_text(statement, 7));
            person.phone = String(cString: sqlite3_column_text(statement, 8));
            person.cell = String(cString: sqlite3_column_text(statement, 9));
            result.append(person)
        }
        
        return result
    }
}
