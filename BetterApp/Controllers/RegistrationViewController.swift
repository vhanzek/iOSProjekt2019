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
            UIUtils.showError(message: "You haven't filled out all the fields.")
            return
        }
        
        // Show error if passwords do not match
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            UIUtils.showError(message: "Passwords don't match.")
            return
        }
        
        // Creating Firebase user
        Spinner.start()
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            Spinner.stop()
            // An error occurred
            guard let user = authResult?.user, error == nil else {
                UIUtils.showError(message: error!.localizedDescription)
                return
            }
            // User successfully created
            UIUtils.showSuccess(message: "User \(user.email!) successfully created.") {
                // Save user to database
                UserService().saveUser(userID: user.uid, email: user.email!)
                // Return to login
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
