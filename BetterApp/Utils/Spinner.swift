//
//  Spinner.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 10/07/2019.
//

import UIKit

class Spinner {
    
    internal static var spinner: UIActivityIndicatorView?
    
    public static func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = UIUtils.colorVistaBlue.withAlphaComponent(0.7)
            spinner!.style = .whiteLarge
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    public static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
    @objc public static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}
