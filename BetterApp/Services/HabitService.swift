//
//  HabitService.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 06/07/2019.
//

import FirebaseDatabase

class HabitService {
    
    func fetchHabits(completion: @escaping (([Habit]?) -> Void)) {
        let habitsRef = FirebaseManager.shared.getCurrentUserHabitsReference()
        
        habitsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let values = snapshot.value as? [String: NSDictionary] {
                let habits = values.compactMap(Habit.init)
                completion(habits)
            } else {
                completion([])
            }
            
        }) { (error) in
            UIUtils.showError(message: error.localizedDescription)
        }
    }
    
    func saveHabit(habitFormData: HabitFormData, completion: @escaping (() -> Void)) {
        let habitsRef = FirebaseManager.shared.getCurrentUserHabitsReference()
        guard let habitKey = FirebaseManager.shared.createHabitAutoId() else {
            UIUtils.showSuccess(message: "Unable to save habit.")
            return
        }
        
        // Create habit to be saved to database
        let habit: [String: Any] = [
            "title": habitFormData.title,
            "category": habitFormData.category,
            "frequency": habitFormData.frequency,
            "repeating": habitFormData.repeating
        ]
        // Add new habit with corresponding key
        habitsRef.updateChildValues(["\(habitKey)": habit])
        // Habit successfully saved
        UIUtils.showSuccess(message: "Habit succesfully saved.") {
            completion()
        }
    }
    
    func deleteHabit(habitID: String, completion: @escaping (() -> Void)) {
        let habitRef = FirebaseManager.shared.getCurrentUserHabitsReference().child(habitID)
        habitRef.removeValue { error, _ in
            if let error = error {
                UIUtils.showError(message: error.localizedDescription)
            } else {
                completion()
            }
        }
    }
}
