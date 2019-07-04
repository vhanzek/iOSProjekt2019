//
//  AppDelegate.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 30/06/2019.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase configuration
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        let vc = LoginViewController()
//
//        window?.rootViewController = vc
        switchToHabitsController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func switchToLoginController() {
        self.window?.rootViewController = LoginViewController()
    }
    
    func switchToHabitsController() {
        let navigationViewController = UINavigationController(
            rootViewController: HabitsViewController(viewModel: HabitsViewModel()))
        self.window?.rootViewController = navigationViewController
    }
}

