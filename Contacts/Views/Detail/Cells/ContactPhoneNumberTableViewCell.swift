//
//  ContactPhoneNumberTableViewCell.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

class ContactPhoneNumberTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var phoneNumberLabel: UILabel!

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
        guard let phoneNumber = user?.phoneNumber else {
            return
        }
        self.phoneNumberLabel.text = "\(phoneNumber)"
    }

}
