//
//  HabitTableViewCell.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit

protocol HabitTableViewCellDelegate: class {
    
    func deleteClicked(forHabit id: String)
}

class HabitTableViewCell: UITableViewCell {
    
    weak var delegate: HabitTableViewCellDelegate?
    private var id: String?
    
    @IBOutlet weak var habitIcon: UIImageView!
    @IBOutlet weak var habitTitle: UILabel!
    
    @IBAction func deleteTapped(_ sender: Any) {
        self.delegate?.deleteClicked(forHabit: self.id!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        habitIcon.image = nil
        habitTitle.text = ""
    }
    
    private func setupTableViewCell() {
        
    }
    
    func setup(withHabit habit: HabitCellModel) {
        self.id = habit.id
        self.habitIcon.image = UIImage(named: habit.category.icon)
        self.habitTitle.text = habit.title
    }
    
}
