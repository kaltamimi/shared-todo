//
//  Category.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 26/02/2021.
//

import Foundation
import RealmSwift

class Category: Object{

    @objc dynamic var id = ""
    @objc dynamic var name: String = ""

    //Create a relationship with "Item" (forward relationship)
    let items = List<Item>() //initialize empty list

    override static func primaryKey() -> String? {
        return "id"
    }
}
