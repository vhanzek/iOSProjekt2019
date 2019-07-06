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
        
        // Firebase configuration
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UIUtils.getRootViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func setRootViewController(viewController: UIViewController) {
        self.window?.rootViewController = viewController
    }

}

