//
//  ToDoUtility.swift
//  ToDo_CRUD_POC
//
//  Created by Sandesh on 23/03/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import Foundation

class ToDoUtility {
    
    private static let key = "tasks"
    
    // archive
    private static func archive(_ tasks: [[Task]]) -> Data {
       let data = try! NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: true) as Data
        return data
    }
    
    // fetch
    static func fetch() -> [[Task]]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        let task =  try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [[Task]]
        return task
    }
    
    // save
    static func save(_ tasks: [[Task]]) {
        
        // archive
        let archivedTasks = archive(tasks)
        
        // set object for key
        UserDefaults.standard.set(archivedTasks, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
