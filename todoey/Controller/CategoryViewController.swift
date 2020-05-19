//
//  CategoryViewController.swift
//  todoey
//
//  Created by Saeed on 5/13/20.
//  Copyright © 2020 Saeed2346. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var listCategory : Results<Category>?


    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    override func viewDidLoad() {
        super.viewDidLoad()
        print(filePath)
     
        loadCategory()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = listCategory?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = category?.name ?? "No Category Added"
        cell.backgroundColor = UIColor.red
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategory?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = listCategory?[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category To Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (alertAction) in
            let newCategory = Category()
            newCategory.name = textField.text!
           
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func save(category : Category){
        
        do {
            try realm.write(){
                realm.add(category)
            }
        } catch  {
            print("error for saving category \(error)")
        }
        tableView.reloadData()
   
    }
    func loadCategory(){
        
        listCategory = realm.objects(Category.self)
    
}
}
extension CategoryViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        listCategory = listCategory?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
    }
//        let request : NSFetchRequest<Categories> = Categories.fetchRequest()
//        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//        loadCategory(with: request)
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadCategory()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
