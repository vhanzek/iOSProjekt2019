//
//  RegistrationViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 30/06/2019.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        // Show error if some fields are empty
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            UIUtils.showOKAlert(
                type: AlertType.ERROR,
                message: "You haven't filled out all the fields.",
                viewController: self
            )
            return
        }
        
        // Show error if passwords do not match
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            UIUtils.showOKAlert(
                type: AlertType.ERROR,
                message: "Passwords don't match.",
                viewController: self
            )
            return
        }
        
        // Creating Firebase user
        self.showSpinner(onView: self.view)
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            self.removeSpinner()
            // An error occurred
            guard let user = authResult?.user, error == nil else {
                UIUtils.showOKAlert(
                    type: AlertType.ERROR,
                    message: error!.localizedDescription,
                    viewController: self
                )
                return
            }
            // User successfully created
            UIUtils.showOKAlert(
                type: AlertType.SUCCESS,
                message: "User \(user.email!) successfully created.",
                viewController: self
            ) {
                // Save user to database
                DataController.saveUser(uid: user.uid, email: user.email!)
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
