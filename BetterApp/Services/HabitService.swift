//
//  HabitService.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 06/07/2019.
//

import FirebaseDatabase

class HabitService {
    
    private final let HABITS = "habits"
    
    func fetchHabits(completion: @escaping (([Habit]?) -> Void)) {
        let ref = Database.database().reference().root
        let userID = AuthenticationUtils.getUserId()!
        
        ref.child(HABITS).child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let values = snapshot.value as? [String: Any] {
                let habits = values.compactMap(Habit.init)
                completion(habits)
            } else {
                completion(nil)
            }
            
        }) { (error) in
            UIUtils.showError(message: error.localizedDescription)
        }
    }
    
    func saveHabit(habitFormData: HabitFormData, completion: @escaping (() -> Void)) {
        let ref = Database.database().reference().root
        let userID = AuthenticationUtils.getUserId()!
        guard let habitKey = ref.child(HABITS).childByAutoId().key else { return }
        
        ref.child(HABITS).child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Create habit to be saved to database
            let habit: [String: String] = [
                "id": habitKey,
                "title": habitFormData.title,
                "category": habitFormData.category,
                "frequency": habitFormData.frequency,
                "repeating": habitFormData.repeating
            ]
            // Add new habit with corresponding key
            ref.updateChildValues(["/habits/\(userID)/\(habitKey)/": habit])
            // Habit successfully saved
            UIUtils.showSuccess(message: "Habit succesfully saved.") {
                completion()
            }
            
        }) { (error) in
            UIUtils.showError(message: error.localizedDescription)
        }
    }
}
