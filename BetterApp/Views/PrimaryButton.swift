//
//  PrimaryButton.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 10/07/2019.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {
    
    @IBInspectable
    var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = UIUtils.colorVistaBlue
    }
}
