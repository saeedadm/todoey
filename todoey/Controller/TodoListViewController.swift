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
        newItem2.title = "ice"
        listArray.append(newItem3)
        
        let newItem4 = Item()
        newItem2.title = "meat"
        listArray.append(newItem4)
        
        let newItem5 = Item()
        newItem2.title = "banana"
        listArray.append(newItem5)
        
        let newItem6 = Item()
        newItem2.title = "peach"
        listArray.append(newItem6)
        
        let newItem7 = Item()
        newItem2.title = "apple"
        listArray.append(newItem7)
        
        let newItem8 = Item()
        newItem2.title = "door"
        listArray.append(newItem8)
        
        let newItem9 = Item()
        newItem2.title = "table"
        listArray.append(newItem9)
        
        let newItem10 = Item()
        newItem2.title = "perfume"
        listArray.append(newItem10)
        
        let newItem11 = Item()
        newItem2.title = "orange"
        listArray.append(newItem11)
        
        
        
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        //        listArray.append(newItem1)
        
        
        //        if (defaults.stringArray(forKey: "TodoList")) != nil{
        //            listArray = defaults.array(forKey: "TodoList") as! [String]
        //        }
    }
    
    //MARK : tableview datasource method
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell For Row At")
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        
        cell.textLabel?.text = listArray[indexPath.row].title
        cell.textLabel?.textColor = UIColor.white
        
        
        //        let cell1 = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        //        cell1.backgroundColor = UIColor.gray
        //        cell1.textLabel?.text = listArray[indexPath.row]
        //        cell1.textLabel?.textColor = UIColor.white
        if listArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
            defaults.set(true, forKey: "done")
        }else{
            cell.accessoryType = .none
            defaults.set(false, forKey: "done")
        }
        
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

