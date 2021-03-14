//
//  LocalContext.swift
//  SharedTodo
//
//  Created by Kawthar Khalid al-Tamimi on 28/02/2021.
//

import RealmSwift

protocol LocalContextProtocol {
    func upsert(objects: [Object], completion: ((Any?) -> ())?)
    func retrieve(from type: Object.Type, filterBy: NSPredicate?, completion: (Any?, [Object]?) -> ())
    func delete(objects: [Object], filterBy filter: NSPredicate?, completion: ((Any?) -> ())?)
    func clearTable(from type: Object.Type, completion: ((Any?) -> ())?)
    func clearLocalDataStorage(completion: ((Any?) -> ())?)
    
    func delete(from type: Object.Type, filterBy: NSPredicate?, completion: ((Any?) -> ())?)
    
    func upsertItemToParent(parentObject: Category, objects: [Object], completion: ((Any?) -> ())?)
}

class LocalContext: LocalContextProtocol {
    
    //MARK: - Properties
    
    private var realm: Realm!
    

    //MARK: - LocalContext Methods
    
    
    /// Insert an object in local storage. If the object exists then update the whole object.
    ///
    /// - Parameters:
    ///   - objects: an Array of Realm Objects
    ///   - completion: a callback function that is invoked when the operation is completed. The function returns true when the operation
    ///                    is successful, and NSError object when the operation has failed.
    func upsert(objects: [Object], completion: ((Any?) -> ())? = nil){
        do {
            self.realm = try Realm()
            try realm.write {
                objects.forEach({ (object) in
                    realm.add(object, update: .all)
                })
                completion?(true)
            }
        }catch(let error as NSError){
            print("Error occured while upserting an object. In \(self), \(#function), \(#line)")
            print("Error: \(error.localizedDescription)")
            completion?(error)
        }
    }
    
    func upsertItemToParent(parentObject: Category, objects: [Object], completion: ((Any?) -> ())? = nil){
        do {
            self.realm = try Realm()
            try realm.write {
                objects.forEach({ (object) in
                    realm.add(object, update: .all)
                    parentObject.items.append(object as! Item)
                })
                completion?(true)
            }
        }catch(let error as NSError){
            print("Error occured while upserting an object. In \(self), \(#function), \(#line)")
            print("Error: \(error.localizedDescription)")
            completion?(error)
        }
    }
    
    /// Retrieves a list of Objects from local storage.
    ///
    /// - Parameters:
    ///   - type: Object type (e.g. Center.self)
    ///   - filterBy: NSPredicate, optional wil nil as default value
    ///   - completion: a callback function that is invoked when the operation is completed. The function returns true and an array of Object when the operation
    ///                    is successful, and NSError object when the operation has failed.
    func retrieve(from type: Object.Type, filterBy: NSPredicate? = nil, completion: (Any?, [Object]?) -> ()){
        do {
            self.realm = try Realm()
            let result = filterBy == nil ? Array(realm.objects(type.self)) : Array(realm.objects(type.self).filter(filterBy!))
            completion(true, result)
        }catch(let error as NSError){
            print("error in view model get category")
            print("Error occured while upserting an object. In \(self), \(#function), \(#line)")
            print("Error: \(error.localizedDescription)")
            completion(error, nil)
        }
    }
    
    
    
    /// Deletes a list of specified Objects from local storage.
    ///
    /// - Parameters:
    ///   - objects: [Object]
    ///   - filter: NSPredicate
    ///   - completion: A callback function invoked when the operation is completed.
    ///            - Paramters:
    ///                - Any?: returns true if the operation has been successful, NSError object if an error has occured.
    func delete(objects: [Object], filterBy filter: NSPredicate? = nil, completion: ((Any?) -> ())? = nil){
        do {
            self.realm = try Realm()
            try realm.write {
                objects.forEach({ (object) in
                    realm.delete(object)
                })
            }
            completion?(true)
        }catch (let error as NSError){
            print("Error occured while upserting an object. In \(self), \(#function), \(#line)")
            print("Error: \(error.localizedDescription)")
            completion?(error)
        }
    }
    
    
    
    /// Retrieves a list of Objects from local storage.
    ///
    /// - Parameters:
    ///   - type: Object type (e.g. Center.self)
    ///   - filterBy: NSPredicate, optional wil nil as default value
    ///   - completion: a callback function that is invoked when the operation is completed. The function returns true and an array of Object when the operation
    ///                    is successful, and NSError object when the operation has failed.
    func clearTable(from type: Object.Type, completion: ((Any?) -> ())? = nil){
        do {
            self.realm = try Realm()
            let objects = try realm.objects(type.self)
            if objects.count > 0{
                try! realm.write {
                    realm.delete(objects)
                }
            }
            completion?(true)
        }catch(let error as NSError){
            print("Error occured while upserting an object. In \(self), \(#function), \(#line)")
            print("Error: \(error.localizedDescription)")
            completion?(error)
        }
        completion?(true)
    }
    
    
    /// Removes all files in local storage.
    ///
    /// - Parameter completion: A callback function that is invoked when the operation is completed.
    public func clearLocalDataStorage(completion: ((Any?) -> ())? = nil){
        print("Clearing local storage. In \(self), \(#function)")
        guard let realmURL = Realm.Configuration.defaultConfiguration.fileURL else {
            print("Error: Could not find Realm local URL.")
            completion?(false)
            return
        }
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch (let error as NSError) {
                print("Error occured while clearing local storage. In \(self), \(#function)")
                print("Error: \(error.localizedDescription)")
                completion?(error)
            }
        }
        print("Local storage has been removed successfully. In \(self), \(#function)")
        completion?(true)
    }
    
    
    
    /// Local migration to Realm database.
    ///
    /// - Parameter completion:
    public func performLocalMigration(completion: ((Any?) -> ())? = nil){
        
    }
    
 
    
       /// Delete a  Specified Object  from local storage.
       ///
       /// - Parameters:
       ///   - type: Object type (e.g. Center.self)
       ///   - filter: NSPredicate
       ///   - completion: A callback function invoked when the operation is completed.
       ///            - Paramters:
       ///                - Any?: returns true if the operation has been successful, NSError object if an error has occured.
    func delete(from type: Object.Type, filterBy filter: NSPredicate? = nil, completion: ((Any?) -> ())? = nil){
        do {
            self.realm = try Realm()
            
            try realm.write {
                realm.delete(realm.objects(type.self).filter(filter!))
            }
            completion?(true)
        }catch (let error as NSError){
            print("Error occured while upserting an object. In \(self), \(#function), \(#line)")
            print("Error: \(error.localizedDescription)")
            completion?(error)
        }
    }
    
    
}//End LocalContext













