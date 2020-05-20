//
//  ViewController.swift
//  todoey
//
//  Created by Saeed on 5/9/20.
//  Copyright © 2020 Saeed2346. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeViewController {
    
    let realm = try! Realm()
    var todoItems : Results<Item>?
    var selectedCategory : Category?{
        didSet{
            loadItem()
        }
    }
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(dataFilePath)
        
        tableView.rowHeight = 70.0
        
        
    }
    
    //MARK : tableview datasource method
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.textLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor.gray
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else
        {
            cell.textLabel?.text = "No Item Added"
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did Selected Row At")
        
        if let item = todoItems?[indexPath.row]{
            do{
            try realm.write(){
                item.done = !item.done
            }
            }catch{
                print("error for saving checkmark status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (alertAction) in
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error for saving Item \(error)")
                }
            }
            self.tableView.reloadData() 
        }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create New Item"
                textField = alertTextField
            }
            
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
    
        
        // MARK - model manupulation method
        
        func loadItem(){
            
            todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
            tableView.reloadData()
            
        }
    
    
        // MARK - Delete Data From Swipe
    
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemForDeletion = todoItems?[indexPath.row]{
            do {
                try realm.write{
                    realm.delete(itemForDeletion)
                }
            } catch  {
                print("Error For Deleting Items , \(error)")
            }
        }
    }
}
extension TodoListViewController: UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        searchBar.delegate = self
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItem(with: request , predicate: predicate)
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()
            
            print(DispatchQueue.main)
            print(searchBar.resignFirstResponder())
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}
