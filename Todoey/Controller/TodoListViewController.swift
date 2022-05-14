//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todoItemsArray = [TodoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: <#T##FileManager.SearchPathDomainMask#>)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listItemText = todoItemsArray[indexPath.row].text
        let cell = UITableViewCell(style: .default, reuseIdentifier: "listTodoItems")
        
        cell.textLabel?.text = listItemText
        if todoItemsArray[indexPath.row].isDone {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    //MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoItemsArray[indexPath.row].isDone = !todoItemsArray[indexPath.row].isDone
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            if let textField = alert.textFields?[0] {
                
                print("\n\n\n===\(textField.text!)===\n\n\n")
                
                let newTodoItem = TodoItem(text: textField.text!)
                
                self.todoItemsArray.append(newTodoItem)

                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Item"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
