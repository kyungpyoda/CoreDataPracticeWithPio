//
//  ViewController.swift
//  CoreDataPracticeWithPio
//
//  Created by 홍경표 on 2020/11/18.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private let pio = Person(name: "Pio", phoneNumber: "010-0101-0101", shortcutNumber: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PersistenceManager.shared.insertPerson(person: pio)
        
    }
    
    @IBAction private func touchedButton(_ sender: Any) {
        let contacts = PersistenceManager.shared.fetch(request: Contact.fetchRequest())
        let txt = contacts.reduce("", {$0 + "\n" + ($1.name ?? "//error")})
        print(txt)
        label.text = txt
    }
    
}
