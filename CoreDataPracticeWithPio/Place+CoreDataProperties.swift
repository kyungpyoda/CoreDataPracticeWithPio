//
//  Place+CoreDataProperties.swift
//  CoreDataPracticeWithPio
//
//  Created by 홍경표 on 2020/11/19.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var category: String
    @NSManaged public var id: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var name: String

}

extension Place : Identifiable {

}

