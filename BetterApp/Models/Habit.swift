//
//  Habit.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import Foundation

enum Category: String {
    
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

enum Frequency: String {
    
    case daily = "DAILY"
    case weekly = "WEEKLY"
    case monthly = "MONTHLY"
    
}

//class Habit {
//    
//    private var title: String
//    private var category: Category
//    private var frequency: Frequency
//    private var repeating: Int
//    private var daysDone: [Date]
//    
//    init(habit: NSDictionary) {
//        
//    }
//}

