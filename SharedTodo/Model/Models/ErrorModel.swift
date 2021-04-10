//
//  ErrorModel.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 03/03/2021.
//

import Foundation

struct ErrorModel: Error, Codable  {
    var message: String?
}
