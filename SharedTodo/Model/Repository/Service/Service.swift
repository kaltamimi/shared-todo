//
//  Service.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 01/03/2021.
//

import Foundation
import RealmSwift

typealias Handler<T> = (Result<T?, ErrorModel>) -> Void

protocol ServiceProtocol{
    
    func saveCategory(category: Category)
    func getCategories(completionHandler: @escaping Handler<[Category]>)
    
    func saveItem(category: Category, item: Item)
    func getItems(completionHandler: @escaping Handler<[Item]>)
}

class Service: ServiceProtocol {
    
    //MARK: Shared Instance
    static var shared: ServiceProtocol = Service()
    
    //MARK: - Properties
    internal lazy var localContext: LocalContextProtocol = LocalContext()
    
    //MARK: - Categories methods
    func saveCategory(category: Category){
        localContext.upsert(objects: [category], completion: nil)
    }
    
    func getCategories(completionHandler: @escaping Handler<[Category]>){
        localContext.retrieve(from: Category.self, filterBy: nil) { (result, objects) in
            if let objects = objects, objects.count > 0 {
                completionHandler(.success(objects as? [Category]))
            }else{
                completionHandler(.failure(ErrorModel(message: "There are no categories")))
            }
        }
    }
    
    //MARK: - Items methods
    func saveItem(category: Category, item: Item){
        localContext.upsertItemToParent(parentObject: category, objects: [item], completion: nil)
//        localContext.upsert(objects: [category.items.append(item)], completion: nil)
    }
    
    func getItems(completionHandler: @escaping Handler<[Item]>){
        localContext.retrieve(from: Item.self, filterBy: nil) { (result, objects) in
            if let objects = objects, objects.count > 0 {
                completionHandler(.success(objects as? [Item]))
            }else{
                completionHandler(.failure(ErrorModel(message: "There are no items")))
            }
        }
    }
     
    
}
