//
//  ViewController.swift
//  ToDo_CRUD_POC
//
//  Created by Sandesh on 23/03/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//


import UIKit

class ToDoController: UITableViewController {
    
    var toDoStore: ToDoStore? {
        didSet {
            toDoStore?.tasks = ToDoUtility.fetch() ?? [[Task](), [Task]()]
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        toDoStore = ToDoStore.init()
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) {_ in
            
            guard let name = alertController.textFields?.first?.text else { return }
            
            let newTask = Task(name: name)
        
            self.toDoStore?.add(newTask, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
        addAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter task name..."
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
        
        alertController.addAction(addAction);
        alertController.addAction(cancelAction);
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func handleTextChanged(_ sender: UITextField) {
        
        guard let alertController = presentedViewController as? UIAlertController,
              let addAction = alertController.actions.first,
              let text = sender.text
              else { return }
        
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDoStore?.tasks[indexPath.section][indexPath.row].name
        
        return cell
    }
    
}

// MARK: - Delegate
extension ToDoController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) {(action, sourceView, completionHandler) in
            
            guard let isDone = self.toDoStore?.tasks[indexPath.section][indexPath.row].isDone else { return }
            
            self.toDoStore?.removeTask(at: indexPath.row, isDone: isDone)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        deleteAction.image = #imageLiteral(resourceName: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.4901960784, blue: 0.4823529412, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: nil) {(action, sourceView, completionHandler) in
            
            self.toDoStore?.tasks[0][indexPath.row].isDone = true
            
            let doneTask = self.toDoStore?.removeTask(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.toDoStore?.add(doneTask ?? Task.init(name: ""), at: 0, isDone: true)
            
            let indexPath = IndexPath(row: 0, section: 1)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        doneAction.image = #imageLiteral(resourceName: "done")
        doneAction.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.7411764706, blue: 0.6509803922, alpha: 1)
        
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [doneAction]) : nil
    }
    
}
