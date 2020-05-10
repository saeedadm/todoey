//
//  ViewController.swift
//  todoey
//
//  Created by Saeed on 5/9/20.
//  Copyright © 2020 Saeed2346. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var listArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let newItem = Item()
        newItem.title = "icecream"
        listArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Milk"
        listArray.append(newItem1)
        
        
        let newItem2 = Item()
        newItem2.title = "Cream"
        listArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "ice"
        listArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "meat"
        listArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "banana"
        listArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title = "peach"
        listArray.append(newItem6)
        
        let newItem7 = Item()
        newItem7.title = "apple"
        listArray.append(newItem7)
        
        let newItem8 = Item()
        newItem8.title = "door"
        listArray.append(newItem8)
        
        let newItem9 = Item()
        newItem9.title = "table"
        listArray.append(newItem9)
        
        let newItem10 = Item()
        newItem10.title = "perfume"
        listArray.append(newItem10)
        
        let newItem11 = Item()
        newItem11.title = "orange"
        listArray.append(newItem11)
    
        
        if let items = defaults.array(forKey: "TodoList") as? [Item]{
            listArray = items
        }
    }
    
    //MARK : tableview datasource method
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell For Row At")
        
        let item = listArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = UIColor.white
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did Selected Row At")
        
        listArray[indexPath.row].done = !listArray[indexPath.row].done
        print(listArray[indexPath.row].title)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("add button")
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (alertAction) in
            
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.listArray.append(newItem)
            
            self.defaults.set(self.listArray, forKey: "TodoList")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}

