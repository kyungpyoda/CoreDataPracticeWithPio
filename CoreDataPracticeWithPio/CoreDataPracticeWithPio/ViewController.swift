//
//  ViewController.swift
//  CoreDataPracticeWithPio
//
//  Created by 홍경표 on 2020/11/18.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private let pio = Person(name: "Pio", phoneNumber: "010-0101-0101", shortcutNumber: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        
        if let entity = entity {
            let person = NSManagedObject(entity: entity, insertInto: context)
            person.setValue(pio.name, forKey: "name")
            person.setValue(pio.phoneNumber, forKey: "phoneNumber")
            person.setValue(pio.shortcutNumber, forKey: "shortcutNumber")
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
