//
//  EditPhoneNumberTableViewCell.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

class EditPhoneNumberTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var phoneNumberTextField: UITextField!

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
        guard let user = user else {
            return
        }
        phoneNumberTextField.text = user.phoneNumber
    }

}
