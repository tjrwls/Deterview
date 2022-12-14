//
//  QuestionStore.swift
//  Deterview
//
//  Created by MIJU on 2022/12/13.
//

import Foundation
import SQLite3

class DBHelper {
    static let shared = DBHelper()
    
    var db : OpaquePointer? //db를 가리키는 포인터
    let databaseName = "deterviewdb.sqlite"
    
    init() {
        self.db = createDB()
    }

    deinit {
        sqlite3_close(db)
    }
    
    private func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        do {
            let dbPath: String = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(databaseName).path
            
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("Successfully created DB. Path: \(dbPath)")
                return db
            }
        } catch {
            print("Error while creating Database -\(error.localizedDescription)")
        }
        return nil
    }
    
    func createTable(){
        // 아래 query의 뜻.
        // mytable이라는 table을 생성한다. 필드는
        // id(int, auto-increment primary key)
        // my_name(String not null)
        // my_age(Int)
        // 로 구성한다.
        // auto-increment 속성은 INTEGER에만 가능하다.
        let query = """
           CREATE TABLE IF NOT EXISTS myTable(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           my_name TEXT NOT NULL,
           my_age INT
           );
           """
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating table has been succesfully done. db: \(String(describing: self.db))")
                
            }
            else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\nsqlte3_step failure while creating table: \(errorMessage)")
            }
        }
        else {
            let errorMessage = String(cString: sqlite3_errmsg(self.db))
            print("\nsqlite3_prepare failure while creating table: \(errorMessage)")
        }
        
        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제.
    }
    
    
    
    func insertData(name: String, age: Int) {
        // id 는 Auto increment 속성을 갖고 있기에 빼줌.
        let insertQuery = "insert into myTable (id, my_name, my_age) values (?, ?, ?);"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 2, name, -1, nil)
            sqlite3_bind_int(statement, 3, Int32(age))
            
        }
        else {
            print("sqlite binding failure")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("sqlite insertion success")
        }
        else {
            print("sqlite step failure")
        }
    }
    
    func readData() -> [MyModel] {
        let query: String = "select * from myTable;"
        var statement: OpaquePointer? = nil
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        // Nil을 인식하지 못하는 것으로..
        var result: [MyModel] = []

        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
           
            let id = sqlite3_column_int(statement, 0) // 결과의 0번째 테이블 값
            let name = String(cString: sqlite3_column_text(statement, 1)) // 결과의 1번째 테이블 값.
            let age = sqlite3_column_int(statement, 2) // 결과의 2번째 테이블 값.
            
            result.append(MyModel(id: Int(id), myName: String(name), myAge: Int(age)))
        }
        sqlite3_finalize(statement)
        
        return result
    }
    
    func updateData(id: Int, name: String, age: Int) {
        var statement: OpaquePointer?
        // 등호 기호는 =이 아니라 ==이다.
        // string 부분은 작은 따옴표 두 개로 감싸줘야 한다.
        let queryString = "UPDATE myTable SET my_name = '\(name)', my_age = \(age) WHERE id == \(id)"
        
        // 쿼리 준비.
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        print("Update has been successfully done")
    }
    
    func deleteData(id: Int) {
        let queryString = "DELETE FROM myTable WHERE id == \(id)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        print("delete has been successfully done")
    }
    
    func deleteTable(tableName: String) {
        let queryString = "DROP TABLE \(tableName)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        print("drop table has been successfully done")
        
    }
    
    private func onSQLErrorPrintErrorMessage(_ db: OpaquePointer?) {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Error preparing update: \(errorMessage)")
        return
    }
}
