//
//  TodoListViewModel.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 13/03/2021.
//

import Foundation

protocol TodoListProtocol {
    
    func saveItemToRealm(category: Category, item: Item)
    func getItemsFromRealm(success: (() -> Void)?, failed: ((Error?) -> Void)?)
    var itemsCount: Int? {get}
    func getItemAt(at index: Int) -> Item?
    func saveItem(category: Category, item: Item)
    
}

class TodoListViewModel: TodoListProtocol {
    
    var itemList = [Item]()
    
    func saveItemToRealm(category: Category, item: Item){
        Service.shared.saveItem(category: category, item: item)
    }
    
    func getItemsFromRealm(success: (() -> Void)?, failed: ((Error?) -> Void)?){
        
        Service.shared.getItems { (result) in
            switch result {
            case .success(let items):
                if let items = items {
                    self.itemList = items
                }
                
                success?()
            case .failure(let error):
                print("error in view model get items")
                failed?(error)
            }
        }
    }
    
    var itemsCount: Int? {
        return itemList.count
    }
    
    func getItemAt(at index: Int) -> Item? {
        return itemList[index]
    }
    
    func saveItem(category: Category, item: Item) {
        itemList.append(item)
        saveItemToRealm(category: category, item: item)
    }
    
    
}
