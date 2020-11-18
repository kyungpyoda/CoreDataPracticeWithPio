//
//  PersistenceManager.swift
//  CoreDataPracticeWithPio
//
//  Created by 홍경표 on 2020/11/18.
//

import Foundation
import CoreData

class PersistenceManager {
    
    static var shared: PersistenceManager = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func insertPOI(poi: POI) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            print(entity.attributesByName.keys)
            managedObject.setValue(poi.id, forKey: "id")
            managedObject.setValue(poi.name, forKey: "name")
            managedObject.setValue(Double(poi.lng), forKey: "lng")
            managedObject.setValue(Double(poi.lat), forKey: "lat")
            managedObject.setValue(poi.imageUrl, forKey: "imageUrl")
            managedObject.setValue(poi.category, forKey: "category")
            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }

    @discardableResult
    func insertPerson(person: Person) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            print(entity.attributesByName.keys)
            managedObject.setValue(person.name, forKey: "name")
            managedObject.setValue(person.phoneNumber, forKey: "phoneNumber")
            managedObject.setValue(person.shortcutNumber, forKey: "shortcutNumber")
            
            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    @discardableResult
    func delete(object: NSManagedObject) -> Bool { self.context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int? {
        do {
            let count = try self.context.count(for: request)
            return count
        } catch {
            return nil
        }
    }

}


