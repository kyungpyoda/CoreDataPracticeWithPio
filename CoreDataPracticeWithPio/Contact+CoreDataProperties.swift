//
//  Contact+CoreDataProperties.swift
//  CoreDataPracticeWithPio
//
//  Created by 홍경표 on 2020/11/18.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var shortcutNumber: Int16
    @NSManaged public var phoneNumber: String?
    @NSManaged public var name: String?

}

extension Contact : Identifiable {

}
