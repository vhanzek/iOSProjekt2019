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
        
        // Fetch habits
        habitsRef.queryOrdered(byChild: "timestamp").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            UIUtils.showError(message: "Unable to save habit.")
            return
        }
        
        // Create habit to be saved to database
        let habit: [String: Any] = [
            "title": habitFormData.title,
            "category": habitFormData.category,
            "frequency": habitFormData.frequency,
            "repeating": habitFormData.repeating,
            "timestamp": ServerValue.timestamp()
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
    
    func saveHabitDayDone(forHabit habitID: String, date: String) -> String? {
        let habitsRef = FirebaseManager.shared.getCurrentUserHabitsReference()
        let habitDaysDoneRef = habitsRef.child(habitID).child(FirebaseConstants.DAYS_DONE)
        
        guard let dateKey = habitDaysDoneRef.childByAutoId().key else {
            UIUtils.showError(message: "Unable to save date.")
            return nil
        }
        // Add new date with corresponding key
        habitDaysDoneRef.updateChildValues(["\(dateKey)": date])
        // Return date id
        return dateKey
    }
    
    func deleteHabitDayDone(forHabit habitID: String, dateID: String, completion: @escaping (() -> Void)) {
        let habitsRef = FirebaseManager.shared.getCurrentUserHabitsReference()
        let habitDayDoneRef = habitsRef.child(habitID).child(FirebaseConstants.DAYS_DONE).child(dateID)
        
        habitDayDoneRef.removeValue { error, _ in
            if let error = error {
                UIUtils.showError(message: error.localizedDescription)
            } else {
                completion()
            }
        }
    }
}
