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
    let frequencyDescription: String
    
    init(habit: Habit) {
        self.id = habit.id
        self.title = habit.title
        self.category = habit.category
        self.frequencyDescription = habit.frequencyDescription
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
    
    public func deleteHabit(forHabit id: String, completion: @escaping () -> Void) {
        HabitService().deleteHabit(habitID: id) {
            completion()
        }
    }
    
    public func numberOfHabits() -> Int {
        return self.habits?.count ?? 0
    }
    
    public func numberOfHabits(section: Int) -> Int {
        let category = currentCategories[section]
        return habitsByCategory(category: category)?.count ?? 0
    }
    
    public var currentCategories: [Category] {
        return Array(Set(habits?.map{$0.category} ?? []))
    }
    
    public func habitViewModel(forIndexPath indexPath: IndexPath, showAll: Bool) -> HabitViewModel? {
        if showAll { return habitViewModel(forRow: indexPath.row) }
        
        let category = currentCategories[indexPath.section]
        guard let habits = habitsByCategory(category: category) else { return nil }
        return HabitViewModel(habit: habits[indexPath.row])
    }
    
    public func habit(forIndexPath indexPath: IndexPath, showAll: Bool) -> HabitCellModel? {
        if showAll { return habit(forRow: indexPath.row) }
        
        let category = currentCategories[indexPath.section]
        guard let habits = habitsByCategory(category: category) else { return nil }
        return HabitCellModel(habit: habits[indexPath.row])
    }
    
    private func habitViewModel(forRow row: Int) -> HabitViewModel? {
        guard let habits = self.habits else { return nil }
        return HabitViewModel(habit: habits[row])
    }
    
    private func habit(forRow row: Int) -> HabitCellModel? {
        guard let habits = self.habits else { return nil }
        return HabitCellModel(habit: habits[row])
    }
    
    private func habitsByCategory(category: Category) -> [Habit]? {
        return habits?.filter{$0.category == category}
    }
    
}
