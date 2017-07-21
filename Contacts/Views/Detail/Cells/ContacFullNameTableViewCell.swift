//
//  ContacFullNameTableViewCell.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

class ContacFullNameTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var fullNameLabel: UILabel!

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
        guard let firstName = user?.firstName, let lastName = user?.lastName else {
            return
        }
        self.fullNameLabel.text = "\(firstName) \(lastName)"
    }

}
