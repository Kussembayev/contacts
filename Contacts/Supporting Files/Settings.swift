//
//  Settings.swift
//  Contacts
//
//  Created by Rauan Kussembayev on 7/21/17.
//  Copyright © 2017 kuzya. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import MagicalRecord

let SETTINGS = Settings.shared

class Settings {

    // MARK: - Lifecycle
    static let shared = Settings()
    private init() {

    }

    // MARK: - Routines
    func frameworksSetup(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        MagicalRecord.setupCoreDataStack(withStoreNamed: "User")
        MagicalRecord.enableShorthandMethods()

        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.green)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
    }

    func addInitialContacts() {
        let preloadKey = UserDefaults.standard.bool(forKey: "MR_HasPreFilledContacts")

        if !preloadKey {
            do {

                if let file = Bundle.main.url(forResource: "contacts", withExtension: "json") {
                    let data = try Data(contentsOf: file)
                    do {
                        let contacts = try JSONDecoder().decode([ContactRecord].self, from: data)

                        for contact in contacts {
                            UserService.shared.addContact(contactRecord: contact)
                        }

                        UserDefaults.standard.set(true, forKey: "MR_HasPreFilledContacts")
                        UserDefaults.standard.synchronize()

                    } catch let err {
                        print("wrong decode \(err)")
                    }
                } else {
                    print("no file")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
