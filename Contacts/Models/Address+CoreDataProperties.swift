//
//  Address+CoreDataProperties.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//
//

import Foundation
import CoreData

extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var streetAddress1: String?
    @NSManaged public var streetAddress2: String?
    @NSManaged public var zipCode: String?
    @NSManaged public var user: User?

}
