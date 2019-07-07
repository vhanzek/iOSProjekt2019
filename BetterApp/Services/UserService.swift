//
//  UserService.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 06/07/2019.
//

import FirebaseDatabase
import FirebaseAuth

class UserService {
    
    private final let USERS = "users"
    
    func saveUser(userID: String, email: String) {
        FirebaseManager.shared.getCurrentUserReference().setValue(email)
    }
    
    func changePassword(oldPassword: String?, newPassword: String?, confirmPassword: String?, completion: @escaping ((Error?) -> Void)) {
        if let old = oldPassword, let new = newPassword, let confirmNew = confirmPassword {
            if (!old.isEmpty && !new.isEmpty && !confirmNew.isEmpty) {
                if (new == confirmNew) {
                    if let email = AuthenticationUtils.getUserEmail() {
                        let credential = EmailAuthProvider.credential(withEmail: email, password: old)
                        AuthenticationUtils.getCurrentUser()?.reauthenticate(with: credential, completion: { (result, error) in
                            if error == nil {
                                AuthenticationUtils.getCurrentUser()?.updatePassword(to: new, completion: { (e) in
                                    completion(e)
                                })
                                UIUtils.showSuccess(message: "Password successfully changed!")
                            } else {
                                UIUtils.showError(message: "Old password is incorrect!")
                                completion(error)
                            }
                        })
                    }
                } else {
                    UIUtils.showError(message: "Passwords don't match!")
                }
            } else {
                UIUtils.showError(message: "Field must not be empty!")
            }
        }
    }
    
    func deleteAccount() {
        FirebaseManager.shared.getCurrentUserReference().removeValue { error, _ in
            if let error = error {
                UIUtils.showError(message: error.localizedDescription)
            }
        }
        
        if let user = AuthenticationUtils.getCurrentUser() {
            user.delete { (error) in
                if let error = error {
                    UIUtils.showError(message: error.localizedDescription)
                } else {
                    UIUtils.switchToLoginController()
                    UIUtils.showSuccess(message: "Your account has been deleted.")
                }
            }
        }
    }
}
