//
//  ContactAddressTableViewCell.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

class ContactAddressTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var addressOneLabel: UILabel!
    @IBOutlet weak var addressTwoLabel: UILabel!

    // MARK: - Properties
    var user: User? {
        didSet {
            setData()
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    private func setData() {
        guard let address = user?.address else {
            return
        }
        self.stateLabel.text = "\(address.state ?? "")"
        self.cityLabel.text = "\(address.city ?? "")"
        self.zipCodeLabel.text = "\(address.zipCode ?? "")"
        self.addressOneLabel.text = "\(address.streetAddress1 ?? "")"
        self.addressTwoLabel.text = "\(address.streetAddress2 ?? "")"
    }

}
