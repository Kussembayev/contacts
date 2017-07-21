//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!

    // MARK: - Properties
    var user: User? {
        didSet {
            setData()
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    private func setData() {
        self.nameLabel.text = user?.firstName
        self.surnameLabel.text = user?.lastName
    }

}
