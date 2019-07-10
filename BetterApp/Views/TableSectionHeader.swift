//
//  TableSectionHeader.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 10/07/2019.
//

import UIKit
import PureLayout

class TableSectionHeader: UIView {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIUtils.colorVistaBlue
        self.addSubview(titleLabel)
        
        titleLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

