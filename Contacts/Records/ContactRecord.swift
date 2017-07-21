//
//  ContactRecord.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import Foundation

struct ContactRecord: Decodable {
    var user: UserRecord
    var address: AddressRecord
}
