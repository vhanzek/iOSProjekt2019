//
//  HabitViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit

class HabitViewController: UIViewController {
    
    var viewModel: HabitViewModel!
    
    convenience init(viewModel: HabitViewModel) {
        self.init()
        self.viewModel = viewModel
    }
}
