//
//  ColorPalette.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 26/01/2021.
//

import UIKit

enum ColorPalette: String {

    case trichromacy
    
    var color : UIColor{
        if #available(iOS 11.0, *) {
            return UIColor(named: self.rawValue) ?? .black
        } else {
            return .black
        }
    }
}
 

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
