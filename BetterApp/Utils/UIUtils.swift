//
//  UIUtils.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 30/06/2019.
//

import UIKit
import FirebaseAuth

enum AlertType: String {
    
    case ERROR = "Error"
    case INFO = "Info"
    case SUCCESS = "Success"
    
}

class HabitFormData {
    
    var title: String
    var category: String
    var frequency: String
    var repeating: Int
    
    init(title: String, category: String, frequency: String, repeating: Int) {
        self.title = title
        self.category = category
        self.frequency = frequency
        self.repeating = repeating
    }
}

class UIUtils {
    
    static let colorVistaBlue =
        UIColor(red: 147/255, green: 216/255, blue: 198/255, alpha: 1)
    
    static func showAlert(title: String, message: String, actions: [UIAlertAction]?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = UIUtils.colorVistaBlue
        actions?.forEach{ alertController.addAction($0) }
        
        let viewController = UIApplication.shared.topMostViewController()
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    static func showCancelYesAlert(title: String, message: String, completion: @escaping (() -> Void)) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in completion() }
        
        UIUtils.showAlert(title: title, message: message, actions: [cancelAction, yesAction])
    }
    
    static func showOkAlert(type: AlertType, message: String, completion: (() -> Void)? = nil) {
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let completion = completion {
                completion()
            }
        }
        UIUtils.showAlert(title: type.rawValue, message: message, actions: [okAction])
    }
    
    static func showError(message: String, completion: (() -> Void)? = nil) {
        showOkAlert(type: AlertType.ERROR, message: message, completion: completion)
    }
    
    static func showSuccess(message: String, completion: (() -> Void)? = nil) {
        showOkAlert(type: AlertType.SUCCESS, message: message, completion: completion)
    }
    
    static func showChangeFieldDialog(field: String) {
        let alertController = UIAlertController(title: "Change " + field, message: "Enter your old and new " + field, preferredStyle: .alert)
        alertController.view.tintColor = UIUtils.colorVistaBlue
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let old = alertController.textFields?[0].text
            let new = alertController.textFields?[1].text
            let confirmNew = alertController.textFields?[2].text
            
            if field == "password" {
                UserService().changePassword(oldPassword: old, newPassword: new, confirmPassword: confirmNew, completion: { (_) in })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Enter old " + field
        }
        alertController.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Enter new " + field
        }
        alertController.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Confirm new " + field
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        let viewController = UIApplication.shared.topMostViewController()
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    static func switchToHabitsController() {
        let habitsViewController = UINavigationController(rootViewController: HabitsViewController(viewModel: HabitsViewModel()))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootViewController(viewController: habitsViewController)
    }
    
    static func switchToLoginController() {
        let loginViewController = LoginViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootViewController(viewController: loginViewController)
    }
    
    static func getRootViewController() -> UIViewController {
        return AuthenticationUtils.isUserLoggedIn() ?
            UINavigationController(rootViewController:
                HabitsViewController(viewModel: HabitsViewModel())) :
            LoginViewController()
    }
}
