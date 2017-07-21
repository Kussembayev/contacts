//
//  EditFullNameTableViewCell.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

class EditFullNameTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!

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
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
    }

}
