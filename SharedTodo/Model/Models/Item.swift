//
//  Item.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 26/01/2021.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    //invers relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
