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
    case household = "HOUSEHOLD"
    case efficiency = "EFFICIENCY"
    case social = "SOCIAL"
    case other = "OTHER"
    
    var icon: String {
        return self.rawValue.lowercased()
    }
}

enum Frequency: String, CaseIterable {
    
    case daily = "DAILY"
    case weekly = "WEEKLY"
    case monthly = "MONTHLY"
    
    var times: String {
        switch self {
        case .daily:
            return "a day"
        case .weekly:
            return "a week"
        case .monthly:
            return "a month"
        }
    }
    
}

class Habit {
    
    var id: String
    var title: String
    var category: Category
    var frequency: Frequency
    var repeating: Int
    var daysDone: [Date: String]
    
    init?(habit: Any) {
        if let (id, habit) = habit as? (String, NSDictionary) {
            if let title = habit["title"] as? String,
               let category = habit["category"] as? String,
               let frequency = habit["frequency"] as? String,
               let repeating = habit["repeating"] as? Int {
            
                self.id = id
                self.title = title
                self.category = Category(rawValue: category) ?? Category.other
                self.frequency = Frequency(rawValue: frequency) ?? Frequency.daily
                self.repeating = repeating
                self.daysDone = [:]
                
                if let daysDone = habit["days_done"] as? [String: String] {
                    daysDone.forEach { [weak self] (dateID, date) in
                        if let date = DateUtils.getDate(value: date) {
                            self?.daysDone[date] = dateID
                        }
                    }
                }
                
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public var frequencyDescription: String {
        return "\(self.repeating) time"
                + (self.repeating == 1 ? " " : "s ")
                + "\(self.frequency.times)"
    }
}
