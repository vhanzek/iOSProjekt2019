//
//  HabitViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit
import FSCalendar

class HabitViewController: UIViewController {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    var viewModel: HabitViewModel!
    
    private let cellReuseIdentifier = "cellReuseIdentifier"
    
    convenience init(viewModel: HabitViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        setupCalendar()
    }
    
    private func setupCalendar() {
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        calendar.allowsMultipleSelection = true        
        viewModel.daysDone.forEach { calendar.select($0) }
    }
}

extension HabitViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.saveDayDone(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.deleteDayDone(date: date) {}
    }
    
}

extension HabitViewController: FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: date, at: position)
        return cell
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
}

