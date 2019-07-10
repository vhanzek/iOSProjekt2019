//
//  SettingsSectionHeader.swift
//  BetterApp
//
//  Created by Luc on 10/07/2019.
//

import Foundation
import UIKit

class SettingsSectionHeader: UIView {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.backgroundColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        titleLabel.textColor = UIUtils.colorVistaBlue
        self.addSubview(titleLabel)
        
        titleLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
