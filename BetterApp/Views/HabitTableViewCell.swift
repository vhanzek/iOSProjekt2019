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
    @IBOutlet weak var habitFrequency: UILabel!
    
    @IBAction func deleteTapped(_ sender: Any) {
        self.delegate?.deleteClicked(forHabit: self.id!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCell()
    }
    
    private func setupTableViewCell() {
        habitTitle.font = UIFont.boldSystemFont(ofSize: 17.0)
        habitFrequency.font = UIFont.systemFont(ofSize: 13.0)
        habitFrequency.textColor = UIColor.lightGray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        habitIcon.image = nil
        habitTitle.text = ""
        habitFrequency.text = ""
    }
    
    func setup(withHabit habit: HabitCellModel) {
        self.id = habit.id
        self.habitIcon.image = UIImage(named: habit.category.icon)
        self.habitTitle.text = habit.title
        self.habitFrequency.text = "\(habit.repeating) time" +
            (habit.repeating == 1 ? " " : "s ") + "\(habit.frequency.times)"
    }
    
}
