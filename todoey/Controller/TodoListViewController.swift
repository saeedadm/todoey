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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(dataFilePath!)
        
        loadItem()
        

        
    }
    
    //MARK : tableview datasource method
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
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
        saveItem()
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
            self.saveItem()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK - model manupulation method
    
    func saveItem(){
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(listArray)
            try data.write(to: dataFilePath!)
            print("saveItem for data : \(data)")
            print("saveItem for encoder :\(encoder)")
            
        }catch{
            print("we have error for encoding \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItem(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            print("loadItem for decoder : \(decoder)")
            print("loadItem for data : \(data)")
            do{
                listArray = try decoder.decode([Item].self, from: data)
            
            }catch{
                print("we have errror decoding \(error)")
            }
        }
    }
}

