//
//  CategoryViewModel.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 01/03/2021.
//

import Foundation

protocol CategoryViewModelProtocol {
    
    func saveCategoryToRealm(category: Category)
    func getCategoriesFromRealm(success: (() -> Void)?, failed: ((Error?) -> Void)?)
    var categoriesCount: Int? {get}
    func getCategoryAt(at index: Int) -> Category?
    func saveCategory(category: Category)
}

class CategoryViewModel: CategoryViewModelProtocol {
    
    var categoryList: [Category] = [Category]()
    
    func saveCategoryToRealm(category: Category){
        Service.shared.saveCategory(category: category)
    }
    
    func getCategoriesFromRealm(success: (() -> Void)?, failed: ((Error?) -> Void)?){
        
        Service.shared.getCategories() { (result) in
            switch result {
            case .success(let categories):
                if let categories = categories {
                    self.categoryList = categories
                }
                
                success?()
            case .failure(let error):
                print("error in view model get category")
                failed?(error)
            }
        }
        
    }
    
    var categoriesCount: Int? {
        return categoryList.count
    }
    
    func getCategoryAt(at index: Int) -> Category? {
        return categoryList[index]
    }
    
    func saveCategory(category: Category) {
        categoryList.append(category)
        saveCategoryToRealm(category: category)
    }
    
}
