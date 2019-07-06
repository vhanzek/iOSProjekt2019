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

class UIUtils {
    
    static func showAlert(title: String, message: String, actions: [UIAlertAction]?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach{ alertController.addAction($0) }
        
        let viewController = UIApplication.shared.topMostViewController()
        viewController?.present(alertController, animated: true, completion: nil)
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
