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
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var frequencyDescriptionLabel: UILabel!
    
    @IBAction func deleteTapped(_ sender: Any) {
        self.delegate?.deleteClicked(forHabit: self.id!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCell()
    }
    
    private func setupTableViewCell() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        frequencyDescriptionLabel.font = UIFont.systemFont(ofSize: 13.0)
        frequencyDescriptionLabel.textColor = UIColor.lightGray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryIcon.image = nil
        titleLabel.text = ""
        frequencyDescriptionLabel.text = ""
    }
    
    func setup(withHabit habit: HabitCellModel) {
        self.id = habit.id
        self.categoryIcon.image = UIImage(named: habit.category.icon)
        self.titleLabel.text = habit.title
        self.frequencyDescriptionLabel.text = habit.frequencyDescription
    }
    
}
