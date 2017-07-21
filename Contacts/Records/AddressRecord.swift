//
//  AddressRecord.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import Foundation

struct AddressRecord: Decodable {
    var city: String?
    var state: String?
    var streetAddress1: String?
    var streetAddress2: String?
    var zipCode: String?
}
