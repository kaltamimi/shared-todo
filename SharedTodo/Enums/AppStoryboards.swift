//
//  AppStoryboards.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 26/02/2021.
//

import UIKit

enum StoryboardID : String {
    
    case todoListViewController = "TodoListViewController"

}

enum AppStoryboard : String {
    
    case todoList = "TodoList"

    
    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file, storyboardID: StoryboardID) -> T {

        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID.rawValue) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}



extension UIViewController {
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard, storyboardID: StoryboardID) -> Self {
        
        return appStoryboard.viewController(viewControllerClass: self,storyboardID: storyboardID)
    }
}


