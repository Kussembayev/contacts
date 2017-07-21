//
//  ViewController.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    fileprivate let contactDetailSegue = "contactDetailSegue"
    fileprivate var contacts = [User]()
    fileprivate let contactCell = "ContactTableViewCell"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 360
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: contactCell, bundle: nil), forCellReuseIdentifier: contactCell)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        listContacts()
    }

    func listContacts() {
        contacts = UserService.shared.listContacts()
        tableView.reloadData()
    }

    // MARK: - Actions    
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddContactViewController")
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func unwindToContacts(segue: UIStoryboardSegue) {}
}

// Table Delegate
extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: contactCell,
                                                       for: indexPath) as? ContactTableViewCell
            else { return UITableViewCell()}
        cell.user = contacts[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: contactDetailSegue, sender: contacts[indexPath.row])
    }
}

// Navigation
extension ContactsViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == contactDetailSegue {
            guard let vc = segue.destination as? ContactDetailViewController
                else { return }
            vc.user = sender as? User
        }
    }
}
