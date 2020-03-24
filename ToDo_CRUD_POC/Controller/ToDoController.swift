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
    
    func printTimestamp() -> String {
           let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
           return timestamp
       }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: ALERT_CONTROLLER_TITLE, message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: ADD_ACTION, style: .default) {_ in
            
            guard let name = alertController.textFields?.first?.text else { return }
            
            let newTask = Task(name: "Title - \(name) Time -  \(self.printTimestamp())")
        
            self.toDoStore?.add(newTask, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        addAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: CANCEL_ACTION, style: .cancel, handler: nil)
        
        alertController.addTextField { textField in
            textField.placeholder = PLACEHOLDER
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

