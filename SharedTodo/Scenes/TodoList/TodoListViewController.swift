//
//  TodoListViewController.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 12/01/2021.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel : TodoListProtocol = TodoListViewModel()
    
    var itemArray: Results<Item>?
    
    var selectedCategory: Category? {
        didSet {
            //Load data
            loadItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setNavigationBar()
        
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor  = ColorPalette.trichromacy.color
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
    }
    
    func configureTableView(){
        tableView.register(ToDoItemCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadItem(){
        
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        viewModel.getItemsFromRealm {
//
//        } failed: { (error) in
//            print(error ?? getLocalizedString(localizedKey: .getFromRealmErrorMsg))
//        }

    }
    

    //MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: getLocalizedString(localizedKey: .addNewItem) , message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: getLocalizedString(localizedKey: .addItem), style: .default) { (action) in
            //what will happen once usser clicks the Add Item button on our UIAlert
            if let item = textField.text {

                let newItem = Item()
                newItem.title = item
                newItem.done = false
                
                if let category = self.selectedCategory {
                    self.viewModel.saveItem(category: category ,item: newItem)
                }
                
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = getLocalizedString(localizedKey: .createNewItem)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - TableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ToDoItemCell = tableView.dequeueReusableCell(at: indexPath)
        
        let item =  itemArray?[indexPath.row]
        cell.textLabel?.text = item?.title ?? "no item"
        cell.accessoryType = item?.done ?? false ? .checkmark : .none
        
        return cell
    }
    
    
}

//MARK: - TableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray?[indexPath.row].done = !(itemArray?[indexPath.row].done ?? false)

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Search bar method
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //fetch data from database
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
