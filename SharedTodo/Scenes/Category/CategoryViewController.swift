//
//  CategoryViewController.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 13/02/2021.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel: CategoryViewModelProtocol = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        loadCategories()

    }
    
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadCategories() {
    
        viewModel.getCategoriesFromRealm {
            
        } failed: { (error) in
            print(error ?? getLocalizedString(localizedKey: .getFromRealmErrorMsg))
        }

    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: getLocalizedString(localizedKey: .createNewCategory) , message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: getLocalizedString(localizedKey: .add), style: .default) { (action) in
            //what will happen once usser clicks the Add Item button on our UIAlert
            if let catrgoryName = textField.text {

                let newCategory = Category()
                newCategory.name = catrgoryName
                
                self.viewModel.saveCategory(category: newCategory)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = getLocalizedString(localizedKey: .addNewCategory)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - TableViewDataSource Methods
extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoriesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.getCategoryAt(at: indexPath.row)?.name
        
        return cell
    }
    
    
}

//MARK: - TableViewDelegate Methods
extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todoController = TodoListViewController.instantiate(fromAppStoryboard: .todoList, storyboardID: .todoListViewController)
        todoController.selectedCategory = viewModel.getCategoryAt(at: indexPath.row)
        let navigation = UINavigationController(rootViewController: todoController)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
        
    }
    
}

//MARK: - Data Mainpulation Methods
extension CategoryViewController {
    
}

