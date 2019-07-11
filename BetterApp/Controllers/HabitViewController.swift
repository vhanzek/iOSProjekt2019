//
//  HabitViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit
import FSCalendar

class HabitViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var previousLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    
    var viewModel: HabitViewModel!
    
    private let cellReuseIdentifier = "cellReuseIdentifier"
    
    convenience init(viewModel: HabitViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Habit details"
        
        setup()
        setupCalendar()
    }
    
    private func setup() {
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.frequencyDescription

        let prevTap = UITapGestureRecognizer(target: self, action: Selector(("previousTapped:")))
        previousLabel.addGestureRecognizer(prevTap)
        let nextTap = UITapGestureRecognizer(target: self, action: Selector(("nextTapped:")))
        nextLabel.addGestureRecognizer(nextTap)
    }
    
    private func setupCalendar() {
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        calendar.allowsMultipleSelection = true
        viewModel.daysDone.forEach { calendar.select($0) }
    }
    
    @IBAction func previousTapped(_ sender: Any) {
        calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
            calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
    }
    
    private func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    private func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
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

