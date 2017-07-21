//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties(public)
    var user: User?

    // MARK: - Properties(private)
    fileprivate let fullNameCell = "ContacFullNameTableViewCell"
    fileprivate let phoneNumberCell = "ContactPhoneNumberTableViewCell"
    fileprivate let addressCell = "ContactAddressTableViewCell"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 360
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: fullNameCell, bundle: nil), forCellReuseIdentifier: fullNameCell)
        tableView.register(UINib(nibName: phoneNumberCell, bundle: nil), forCellReuseIdentifier: phoneNumberCell)
        tableView.register(UINib(nibName: addressCell, bundle: nil), forCellReuseIdentifier: addressCell)
    }

    // MARK: - Actions
    @IBAction func editAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AddContactViewController")
            as? AddContactViewController
            else { return }
        vc.user = self.user
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }

}

// AddContactViewControllerDelegate
extension ContactDetailViewController: AddContactViewControllerDelegate {
    func updateUser(user: User?) {
        self.user = user
        self.tableView.reloadData()
    }
}

// Table Delegate
extension ContactDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: fullNameCell,
                                                           for: indexPath) as? ContacFullNameTableViewCell
                else { return UITableViewCell() }
            cell.user = self.user
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: phoneNumberCell,
                                                           for: indexPath) as? ContactPhoneNumberTableViewCell
                else { return UITableViewCell() }
            cell.user = self.user
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: addressCell,
                                                           for: indexPath) as? ContactAddressTableViewCell
                else { return UITableViewCell() }
            cell.user = self.user
            return cell
        default:
            return UITableViewCell()
        }

    }

}
