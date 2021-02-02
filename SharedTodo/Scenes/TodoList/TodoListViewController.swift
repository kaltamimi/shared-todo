//
//  TodoListViewController.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 12/01/2021.
//

import UIKit

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let userDefualt = UserDefaults.standard
    
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setNavigationBar()
        setupData()
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
    
    func setupData(){
        
        let newItem = Item(title: "Milk", done: true)
        let newItem2 = Item(title: "Honey", done: false)
        let newItem3 = Item(title: "egg", done: true)
    
        itemArray.append(newItem)
        itemArray.append(newItem2)
        itemArray.append(newItem3)
    }
    


    //MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: getLocalizedString(localizedKey: .addNewItem) , message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: getLocalizedString(localizedKey: .addItem), style: .default) { (action) in
            //what will happen once usser clicks the Add Item button on our UIAlert
            if let item = textField.text {
                self.itemArray.append(Item(title: item, done: false))
                self.userDefualt.setValue(item, forKey: Constant.todoArrayKey)
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
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ToDoItemCell = tableView.dequeueReusableCell(at: indexPath)
        
        let item =  itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
}

//MARK: - TableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


