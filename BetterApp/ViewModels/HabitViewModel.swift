//
//  HabitViewModel.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import Foundation

class HabitViewModel {
    
    private let habit: Habit?
    
    init(habit: Habit?) {
        self.habit = habit
    }
    
    public var id: String {
        return habit?.id ?? ""
    }
    
    public var daysDone: [Date] {
        return Array(habit?.daysDone.keys ?? [:].keys)
    }
    
    public func dayDoneId(date: Date) -> String? {
        return habit?.daysDone[date]
    }
    
    public func saveDayDone(date: Date) {
        guard let dateString = DateUtils.getString(date: date) else { return }
        if let dateID = HabitService().saveHabitDayDone(forHabit: self.id, date: dateString) {
            guard let habit = self.habit else { return }
            habit.daysDone[date] = dateID
        }
    }
    
    public func deleteDayDone(date: Date, completion: @escaping (() -> Void)) {
        guard let habit = self.habit else { return }
        guard let dateID = self.dayDoneId(date: date) else { return }
        habit.daysDone.removeValue(forKey: date)
        
        HabitService().deleteHabitDayDone(forHabit: habit.id, dateID: dateID) {
            completion()
        }
    }
}
