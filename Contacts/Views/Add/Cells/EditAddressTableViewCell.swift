//
//  EditAddressTableViewCell.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

protocol EditAddressTableViewCellDelegate: class {
    func scrollToField(toY: CGFloat)
}

class EditAddressTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var addressOneTextField: UITextField!
    @IBOutlet weak var addressTwoTextField: UITextField!

    // MARK: - Properties
    var user: User? {
        didSet {
            setData()
        }
    }
    
    weak var delegate: EditAddressTableViewCellDelegate?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        addressTwoTextField.delegate = self
        addressOneTextField.delegate = self
        zipCodeTextField.delegate = self
    }

    private func setData() {
        guard let address = user?.address else {
            return
        }
        self.stateTextField.text = "\(address.state ?? "")"
        self.cityTextField.text = "\(address.city ?? "")"
        self.zipCodeTextField.text = "\(address.zipCode ?? "")"
        self.addressOneTextField.text = "\(address.streetAddress1 ?? "")"
        self.addressTwoTextField.text = "\(address.streetAddress2 ?? "")"
    }
}

// UITextFieldDelegate
extension EditAddressTableViewCell: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.delegate?.scrollToField(toY: textField.center.y)
        return true
    }

}
