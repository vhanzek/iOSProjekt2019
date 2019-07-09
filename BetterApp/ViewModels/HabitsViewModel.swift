//
//  HabitsViewModel.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import FirebaseDatabase

struct HabitCellModel {
    
    let id: String
    let title: String
    let category: Category
    let frequency: Frequency
    let repeating: Int
    
    init(habit: Habit) {
        self.id = habit.id
        self.title = habit.title
        self.category = habit.category
        self.frequency = habit.frequency
        self.repeating = habit.repeating
    }
}

class HabitsViewModel {
    
    private var habits: [Habit]?
    
    public func fetchHabits(completion: @escaping () -> Void) {
        HabitService().fetchHabits(completion: { [weak self] (habits) in
            self?.habits = habits
            completion()
        })
    }
    
    public func deleteHabit(forHabit id: String, completion: @escaping (() -> Void)) {
        UIUtils.showCancelYesAlert(
        title: "Delete habit", message: "Are you sure you want to delete this habit?") {
            HabitService().deleteHabit(habitID: id) {
                completion()
            }
        }
    }
    
    public func numberOfHabits() -> Int {
        return self.habits?.count ?? 0
    }
    
    public func numberOfHabits(category: Category) -> Int {
        return habitsByCategory(category: category)?.count ?? 0
    }
    
    public func habitViewModel(forRow row: Int) -> HabitViewModel? {
        guard let habits = self.habits else { return nil }
        return HabitViewModel(habit: habits[row])
    }
    
    public func habitViewModel(forIndexPath indexPath: IndexPath) -> HabitViewModel? {
        let category = Category.allCases[indexPath.section]
        guard let habits = habitsByCategory(category: category) else { return nil }
        return HabitViewModel(habit: habits[indexPath.row])
    }
    
    public func habit(forRow row: Int) -> HabitCellModel? {
        guard let habits = self.habits else { return nil }
        return HabitCellModel(habit: habits[row])
    }
    
    public func habit(forIndexPath indexPath: IndexPath) -> HabitCellModel? {
        let category = Category.allCases[indexPath.section]
        guard let habits = habitsByCategory(category: category) else { return nil }
        return HabitCellModel(habit: habits[indexPath.row])
    }
    
    public func habitsByCategory(category: Category) -> [Habit]? {
        return habits?.filter{$0.category == category}
    }
    
}
