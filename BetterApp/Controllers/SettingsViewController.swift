//
//  SettingsViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            UIUtils.showOKAlert(
                type: AlertType.ERROR,
                message: error.localizedDescription,
                viewController: self
            )
        }
        UIUtils.switchToLoginController()
    }
    
}
