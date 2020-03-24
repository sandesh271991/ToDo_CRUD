//
//  ToDoController-Extension+TableViewDataSource.swift
//  ToDo_CRUD_POC
//
//  Created by Sandesh on 24/03/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import Foundation
import UIKit


// MARK: - DataSource
extension ToDoController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "To-do" : "Done"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return toDoStore?.tasks.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count:\(toDoStore?.tasks[section].count ?? 0)")
        return toDoStore?.tasks[section].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = toDoStore?.tasks[indexPath.section][indexPath.row].name
        
        return cell
    }
    
}

