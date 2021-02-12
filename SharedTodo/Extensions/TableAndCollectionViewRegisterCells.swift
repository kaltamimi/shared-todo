//
//  TableAndCollectionViewRegisterCells.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 20/01/2021.
//

import UIKit

protocol CellIdentifiable {
    static var cellIdentifier: String { get }
}


extension CellIdentifiable where Self: UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
}



extension UITableViewCell: CellIdentifiable { }


extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        let nib  = UINib(nibName: T.cellIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.cellIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as? T else {
            
            fatalError("Error dequeuing cell for identifier \(T.cellIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T else {
            
            fatalError("Error dequeuing cell for identifier \(T.cellIdentifier)")
        }
        
        return cell
    }
}



extension CellIdentifiable where Self: UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: CellIdentifiable { }


extension UICollectionView {
     
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        let nib  = UINib(nibName: T.cellIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.cellIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as? T else {
            
            fatalError("Error dequeuing cell for identifier \(T.cellIdentifier)")
        }
        
        return cell
    }
}

