//
//  LocalizableUtilite.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 02/02/2021.
//


import UIKit

func getLocalizedString(localizedKey :LocalizedKey) -> String{
    
    let formatString = NSLocalizedString(localizedKey.rawValue, comment: "")
    
    return formatString
}


extension UITextField{
    
    func LocalizedString(_ localizedKey: LocalizedKey){
        
        self.placeholder = getLocalizedString(localizedKey: localizedKey)
    }
    
}

extension UIButton{
    
    func LocalizedString(_ localizedKey: LocalizedKey){
        
        self.setTitle(getLocalizedString(localizedKey: localizedKey) , for: .normal)
        
    }
}


extension UILabel{
    
    func LocalizedString(_ localizedKey: LocalizedKey){
        
        self.text = getLocalizedString(localizedKey: localizedKey)
        
    }
}


enum LocalizedKey: String {
    
    //Item
    case createNewItem
    case addNewItem
    case addItem
    
    //Category
    case createNewCategory
    case addNewCategory
    case add
}
  


