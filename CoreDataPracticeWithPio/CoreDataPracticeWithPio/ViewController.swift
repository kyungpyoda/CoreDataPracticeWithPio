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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fetchAll))
        textView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func touchedInsertButton(_ sender: Any) {
        insertAll()
    }
    @IBAction func touchedDeleteAllButton(_ sender: Any) {
        clear()
    }
    @objc func fetchAll() {
        let places = PersistenceManager.shared.fetch(request: Place.fetchRequest())
        let txt = places.reduce("", {$0 + "\n" + ($1.name ?? "//error")})
        print(places.count)
        print(txt)
        textView.text = txt
    }
    func insertAll() {
        guard let count = PersistenceManager.shared.count(request: Place.fetchRequest()),
              count == 0 else { return }
        
        guard let data = NSDataAsset(name: "restaurant_list")?.data else {
            fatalError("Missing data asset: restaurant_list")
        }
        do {
            let json = try JSONDecoder().decode([POI].self, from: data)
            json.forEach({
                PersistenceManager.shared.insertPOI(poi: $0)
            })
        } catch {
            print(error)
        }
    }
    func clear() {
        PersistenceManager.shared.deleteAll(request: Place.fetchRequest())
    }
}

struct POI {
    var id: String
    var name: String
    var lng: Double
    var lat: Double
    var imageUrl: String?
    var category: String
}

extension POI: Codable {
    enum CodingKeys: String, CodingKey {
        case lng = "x"
        case lat = "y"
        case id, name, imageUrl, category
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.id = try! container.decode(String.self, forKey: .id)
        self.lng = Double(try! container.decode(String.self, forKey: .lng))!
        self.lat = Double(try! container.decode(String.self, forKey: .lat))!
        self.imageUrl = try? container.decode(String?.self, forKey: .imageUrl)
        self.category = try! container.decode(String.self, forKey: .category)
    }
}

struct RestaurantList: Codable {
    var places: [POI]
}
