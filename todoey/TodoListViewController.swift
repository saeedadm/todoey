//
//  ViewController.swift
//  todoey
//
//  Created by Saeed on 5/9/20.
//  Copyright © 2020 Saeed2346. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    let listArray = ["icecream" , "Peach" , "banana" , "meat" , "cream" , "milk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK : tableview datasource method
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        
        cell.textLabel?.text = listArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
    
        
//        let cell1 = UITableViewCell(style: .subtitle, reuseIdentifier: "ToDoItemCell")
//        cell1.backgroundColor = UIColor.gray
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

