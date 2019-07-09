//
//  AddHabitViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit

class NewHabitViewController: UIViewController {
    
    @IBOutlet weak var repeatingContentView: UIStackView!
    @IBOutlet weak var newHabitNameTextField: UITextField!
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var frequencySegmentedControl: UISegmentedControl!
    @IBOutlet weak var numberOfTimesTextField: UITextField!
    @IBOutlet weak var categoryName: UILabel!
    
    
    @IBAction func categorySelected(_ sender: Any) {
        switch categoriesSegmentedControl.selectedSegmentIndex {
        case 0:
            categoryName.text = Category.health.rawValue
        case 1:
            categoryName.text = Category.fitness.rawValue
        case 2:
            categoryName.text = Category.selfDevelopment.rawValue
        case 3:
            categoryName.text = Category.household.rawValue
        case 4:
            categoryName.text = Category.efficiency.rawValue
        case 5:
            categoryName.text = Category.social.rawValue
        case 6:
            categoryName.text = Category.other.rawValue
        default:
            categoryName.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Create new habit"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }
    
    @objc func doneTapped() {
        let title = newHabitNameTextField.text ?? ""
        let category = Category.allCases[categoriesSegmentedControl.selectedSegmentIndex]
        let frequency = Frequency.allCases[frequencySegmentedControl.selectedSegmentIndex]
        let numberOfTimes = numberOfTimesTextField.text ?? ""
        
        // Check for errors
        if title.isEmpty || numberOfTimes.isEmpty {
            UIUtils.showError(message: "You haven't filled out all the fields.")
            return
        }
        guard let repeating = Int(numberOfTimes) else {
            UIUtils.showError(message: "Number of times must be a number.")
            return
        }
        
        // Create habit form data
        let habitFormData = HabitFormData(
            title: title,
            category: category.rawValue,
            frequency: frequency.rawValue,
            repeating: repeating
        )
        
        // Save new habit to database
        HabitService().saveHabit(habitFormData: habitFormData) {
            self.navigationController?.popViewController(animated: true)
            let vc = UIApplication.shared.topMostViewController() as? HabitsViewController
            DispatchQueue.main.async {
                vc?.updateData()
            }
        }
    }
}
