//
//  HabitTableViewCell.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var habitIcon: UIImageView!
    @IBOutlet weak var habitTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        habitIcon?.image = nil
        habitTitle.text = ""
    }
    
    private func setupTableViewCell() {
        
    }
    
    func setup() {
        
    }
    
}
