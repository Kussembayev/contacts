//
//  UserRecord.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import Foundation

struct UserRecord: Decodable {
    var contactID: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
}
