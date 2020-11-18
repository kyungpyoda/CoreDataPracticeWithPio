//
//  ViewController.swift
//  CoreDataPracticeWithPio
//
//  Created by 홍경표 on 2020/11/18.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private let pio = Person(name: "Pio", phoneNumber: "010-0101-0101", shortcutNumber: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PersistenceManager.shared.insertPerson(person: pio)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fetchAll))
        textView.addGestureRecognizer(tapGesture)
    }
    
        let contacts = PersistenceManager.shared.fetch(request: Contact.fetchRequest())
        let txt = contacts.reduce("", {$0 + "\n" + ($1.name ?? "//error")})
    @IBAction private func touchedInsertButton(_ sender: Any) {
    }
    @IBAction func touchedDeleteAllButton(_ sender: Any) {
    }
    @objc func fetchAll() {
        let places = PersistenceManager.shared.fetch(request: Place.fetchRequest())
        let txt = places.reduce("", {$0 + "\n" + ($1.name ?? "//error")})
        print(places.count)
        print(txt)
        textView.text = txt
    }
    
}
