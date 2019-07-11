//
//  AddHabitViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit

class NewHabitViewController: UIViewController {
    
    @IBOutlet weak var newHabitNameTextField: UITextField!
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var frequencySegmentedControl: UISegmentedControl!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var repeatingLabel: UILabel!
    @IBOutlet weak var repeatingStepper: UIStepper!
    
    
    @IBAction func frequencySelected(_ sender: Any) {
        let numberOfTimes = String(format:"%.0f", repeatingStepper.value)

        var frequency = "day"
        switch frequencySegmentedControl.selectedSegmentIndex {
        case 0:
            frequency = "day"
        case 1:
            frequency = "week"
        case 2:
            frequency = "month"
        default:
            frequency = "day"
        }

        if (numberOfTimes == "1") {
            repeatingLabel.text = "Repeat 1 time a " + frequency
        } else {
            repeatingLabel.text = "Repeat " + numberOfTimes + " times a " + frequency
        }
    }
    
    @IBAction func stepperTapped(_ sender: Any) {
        let numberOfTimes = String(format:"%.0f", repeatingStepper.value)
        
        var frequency = "day"
        switch frequencySegmentedControl.selectedSegmentIndex {
        case 0:
            frequency = "day"
        case 1:
            frequency = "week"
        case 2:
            frequency = "month"
        default:
            frequency = "day"
        }
        
        if (numberOfTimes == "1") {
            repeatingLabel.text = "Repeat 1 time a " + frequency
        } else {
            repeatingLabel.text = "Repeat " + numberOfTimes + " times a " + frequency
        }
        
    }
    
    @IBAction func categorySelected(_ sender: Any) {
        categoryName.text = Category.allCases[categoriesSegmentedControl.selectedSegmentIndex].name
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
        let numberOfTimes = String(format:"%.0f", repeatingStepper.value)

        
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
