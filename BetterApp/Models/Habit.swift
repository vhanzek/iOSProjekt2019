//
//  Habit.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import Foundation

enum Category: String, CaseIterable {
    
    case health = "HEALTH"
    case fitness = "FITNESS"
    case selfDevelopment = "SELF_DEVELOPMENT"
    case house = "HOUSE"
    case efficiency = "EFFICIENCY"
    case other = "OTHER"
    
    var icon: String {
        return self.rawValue.lowercased()
    }
}

enum Frequency: String, CaseIterable {
    
    case daily = "DAILY"
    case weekly = "WEEKLY"
    case monthly = "MONTHLY"
    
}

class HabitFormData {
    
    var title: String
    var category: String
    var frequency: String
    var repeating: String
    
    init(title: String, category: String, frequency: String, repeating: String) {
        self.title = title
        self.category = category
        self.frequency = frequency
        self.repeating = repeating
    }
}

class Habit {
    
    var id: String
    var title: String
    var category: Category
    var frequency: Frequency
    var repeating: Int
    var daysDone: [Date]
    
    init?(habit: Any) {
        if let habit = habit as? NSDictionary {
            if let id = habit["id"] as? String,
               let title = habit["title"] as? String,
               let category = habit["category"] as? String,
               let frequency = habit["frequency"] as? String,
               let repeating = habit["repeating"] as? Int {
            
                self.id = id
                self.title = title
                self.category = Category(rawValue: category) ?? Category.other
                self.frequency = Frequency(rawValue: frequency) ?? Frequency.daily
                self.repeating = repeating
                self.daysDone = []
                
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
