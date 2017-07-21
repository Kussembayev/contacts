//
//  EditContactViewController.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

protocol AddContactViewControllerDelegate: class {
    func updateUser(user: User?)
}

class AddContactViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var customNavigationItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties(public)
    var isEditMode = false
    var user: User?
    weak var delegate: AddContactViewControllerDelegate?

    // MARK: - Properties(private)
    fileprivate let fullNameCell = "EditFullNameTableViewCell"
    fileprivate let phoneNumberCell = "EditPhoneNumberTableViewCell"
    fileprivate let addressCell = "EditAddressTableViewCell"
    fileprivate let deleteCell = "DeleteContactTableViewCell"
    fileprivate let unwindToContactsSegue = "unwindToContactsSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        if user == nil {
            customNavigationItem.title = "New contact"
            self.isEditMode = false
        } else {
            customNavigationItem.title = " "
            self.isEditMode = true
        }

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 360
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: fullNameCell, bundle: nil), forCellReuseIdentifier: fullNameCell)
        tableView.register(UINib(nibName: phoneNumberCell, bundle: nil), forCellReuseIdentifier: phoneNumberCell)
        tableView.register(UINib(nibName: addressCell, bundle: nil), forCellReuseIdentifier: addressCell)
        tableView.register(UINib(nibName: deleteCell, bundle: nil), forCellReuseIdentifier: deleteCell)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.addUser),
                                               name: NSNotification.Name.UIKeyboardDidHide,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardDidHide,
                                                  object: nil)
    }

    // MARK: - Actions
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func doneAction(_ sender: Any) {
        hideKeyboard()
    }

    @objc private func addUser() {
        let index = IndexPath(row: 0, section: 0)
        let indexOne = IndexPath(row: 1, section: 0)
        let indexTwo = IndexPath(row: 2, section: 0)
        
        guard let fullNameCell = self.tableView.cellForRow(at: index) as? EditFullNameTableViewCell
            else { return }
        guard let phoneCell = self.tableView.cellForRow(at: indexOne) as? EditPhoneNumberTableViewCell
            else { return }
        guard let addressCell = self.tableView.cellForRow(at: indexTwo) as? EditAddressTableViewCell
            else { return }
        let firstName = fullNameCell.firstNameTextField.text
        let lastName = fullNameCell.lastNameTextField.text
        let phoneNumber = phoneCell.phoneNumberTextField.text
        let state = addressCell.stateTextField.text
        let city = addressCell.cityTextField.text
        let zipCode = addressCell.zipCodeTextField.text
        let address1 = addressCell.addressOneTextField.text
        let address2 = addressCell.addressTwoTextField.text

        let userRecord = UserRecord(contactID: UUID().uuidString,
                                    firstName: firstName,
                                    lastName: lastName,
                                    phoneNumber: phoneNumber)
        let addressRecord = AddressRecord(city: city,
                                          state: state,
                                          streetAddress1: address1,
                                          streetAddress2: address2,
                                          zipCode: zipCode)

        let contactRecord = ContactRecord(user: userRecord, address: addressRecord)
        self.editUser(contactRecord: contactRecord)
    }

    private func hideKeyboard() {
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.view.endEditing(true)
    }

    func editUser(contactRecord: ContactRecord) {

        if isEditMode {
            UserService.shared.updateContact(user: self.user, contactRecord: contactRecord, onCompletion: { (user) in
                self.delegate?.updateUser(user: user)

            })
        } else {
            UserService.shared.addContact(contactRecord: contactRecord)
        }
        self.dismiss(animated: true, completion: nil)
    }

}

// Table Delegate
extension AddContactViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEditMode {
            return 4
        }
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: fullNameCell,
                                                     for: indexPath) as? EditFullNameTableViewCell
                else { return UITableViewCell() }
            cell.user = self.user
            cell.tag = indexPath.row
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: phoneNumberCell,
                                                     for: indexPath) as? EditPhoneNumberTableViewCell
                else { return UITableViewCell() }
            cell.user = self.user
            cell.tag = indexPath.row
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: addressCell,
                                                     for: indexPath) as? EditAddressTableViewCell
                else { return UITableViewCell() }
            cell.user = self.user
            cell.tag = indexPath.row
            cell.delegate = self
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: deleteCell,
                                                     for: indexPath) as? DeleteContactTableViewCell
                else { return UITableViewCell() }
            return cell

        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            UserService.shared.deleteContact(user: self.user)
            performSegue(withIdentifier: unwindToContactsSegue, sender: self)
        }
    }
}

// EditAddressTableViewCellDelegate
extension AddContactViewController: EditAddressTableViewCellDelegate {
    func scrollToField(toY: CGFloat) {
        tableView.setContentOffset(CGPoint(x: 0, y: toY - 60), animated: true)
    }
}
