//
//  UserService.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import Foundation
import MagicalRecord

class UserService {

    static let shared = UserService()

    func addContact(contactRecord: ContactRecord) {

        let user = User.mr_createEntity()
        user?.contactID = contactRecord.user.contactID
        user?.firstName = contactRecord.user.firstName
        user?.lastName = contactRecord.user.lastName
        user?.phoneNumber = contactRecord.user.phoneNumber
        user?.address = Address.mr_createEntity()
        user?.address?.city = contactRecord.address.city
        user?.address?.state = contactRecord.address.state
        user?.address?.streetAddress1 = contactRecord.address.streetAddress1
        user?.address?.streetAddress2 = contactRecord.address.streetAddress2
        user?.address?.zipCode = contactRecord.address.zipCode

        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: nil)

    }

    func updateContact(user: User?, contactRecord: ContactRecord, onCompletion: @escaping (User?) -> Void) {

        user?.contactID = contactRecord.user.contactID
        user?.firstName = contactRecord.user.firstName
        user?.lastName = contactRecord.user.lastName
        user?.phoneNumber = contactRecord.user.phoneNumber
        user?.address = Address.mr_createEntity()
        user?.address?.city = contactRecord.address.city
        user?.address?.state = contactRecord.address.state
        user?.address?.streetAddress1 = contactRecord.address.streetAddress1
        user?.address?.streetAddress2 = contactRecord.address.streetAddress2
        user?.address?.zipCode = contactRecord.address.zipCode

        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: nil)
        onCompletion(user)
    }

    func deleteContact(user: User?) {
        user?.mr_deleteEntity()
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: nil)
    }

    func listContacts() -> [User] {
        guard let contacts = User.mr_findAll() as? [User] else { return []}
        let sortedContacts = contacts.sorted(by: { $0.firstName! < $1.firstName! })
        return sortedContacts
    }

}
