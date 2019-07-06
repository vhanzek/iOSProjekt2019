//
//  Database.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import FirebaseDatabase

class DataConstants {
    
    public static let USERS = "users"
    public static let HABITS = "habits"
}

class DataController {
    
    static let shared = DataController()
    
    private init() {}
    
    public lazy var database = Database.database().reference()
    
    public static func saveUser(uid: String, email: String) {
        shared.database.root.child(DataConstants.USERS).child(uid).setValue(email)
    }
}
