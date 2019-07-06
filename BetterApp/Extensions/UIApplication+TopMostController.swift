//
//  UIApplication+TopMostController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 06/07/2019.
//

import UIKit

extension UIApplication {
    
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
