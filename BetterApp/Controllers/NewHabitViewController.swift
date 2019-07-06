//
//  AddHabitViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit

class NewHabitViewController: UIViewController {
    
    private let daysSegmentedControl = UISegmentedControl(items: ["M", "T", "W", "T", "F", "S", "S"])
    private let numberOfDaysSegmentedControl = UISegmentedControl(items: ["1", "2", "3", "4", "5", "6"])
    private let timeOfAMonthSegmentedControl = UISegmentedControl(items: ["start", "middle", "end"])
    
    @IBOutlet weak var repeatingContentView: UIStackView!
    @IBOutlet weak var newHabitNameTextField: UITextField!
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var frequencySegmentrdControl: UISegmentedControl!
    @IBOutlet weak var repeatingLabel: UILabel!
    
    
    @IBAction func categorySelected(_ sender: Any) {
        
    
    }
    
    @IBAction func frequencySelected(_ sender: Any) {
    
        let repeatingSegmentedControl = repeatingContentView.arrangedSubviews[repeatingContentView.arrangedSubviews.count-1]
        repeatingContentView.removeArrangedSubview(repeatingSegmentedControl)
        repeatingSegmentedControl.removeFromSuperview()
        
        switch frequencySegmentrdControl.selectedSegmentIndex {
        case 0:
            repeatingLabel.text = "Choose days:"
            repeatingContentView.addArrangedSubview(daysSegmentedControl)
        case 1:
            repeatingLabel.text = "Choose number of days:"            
            repeatingContentView.addArrangedSubview(numberOfDaysSegmentedControl)
        case 2:
            repeatingLabel.text = "Choose time of a month:"
            repeatingContentView.addArrangedSubview(timeOfAMonthSegmentedControl)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New habit"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        frequencySelected(self)
    }
    
    @objc func doneTapped() {
        
    }
}
