//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var todoItemsArray = [TodoItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))        
        loadItems()
        
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
        
//        context.delete(todoItemsArray[indexPath.row])
//        todoItemsArray.remove(at: indexPath.row)
        
        todoItemsArray[indexPath.row].isDone = !todoItemsArray[indexPath.row].isDone
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveItems()
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            if let textField = alert.textFields?[0] {
                
                print("\n\n\n===\(textField.text!)===\n\n\n")
                
                let newTodoItem = TodoItem(context: self.context)
                newTodoItem.text = textField.text!
                newTodoItem.isDone = false
                
                self.todoItemsArray.append(newTodoItem)
                
                self.saveItems()
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Item"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }

        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()) {
        
        do {
            todoItemsArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
        
        tableView.reloadData()
    }
}

//MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        request.predicate = NSPredicate(format: "text CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
        } else {
            let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
            
            request.predicate = NSPredicate(format: "text CONTAINS[cd] %@", searchBar.text!)
            
            request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
            
            loadItems(with: request)
        }
    }
}
