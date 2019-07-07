//
//  DatabaseUtils.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 07/07/2019.
//

import FirebaseDatabase

class FirebaseConstants {
    
    public static let HABITS = "habits"
    public static let USERS = "users"
}

class FirebaseManager {
    

    
    static let shared = FirebaseManager()
    
    private let reference = Database.database().reference()
    
    private init() {}
    
    public func getDatabaseReference(forName name: String) -> DatabaseReference {
        let userID = AuthenticationUtils.getUserId()!
        return reference.root.child(name).child(userID)
    }
    
    public func createAutoId(forName name: String) -> String? {
        return reference.root.child(name).childByAutoId().key
    }
}

// Habits references
extension FirebaseManager {
    
    public func getCurrentUserHabitsReference() -> DatabaseReference {
        return getDatabaseReference(forName: FirebaseConstants.HABITS)
    }
    
    public func createHabitAutoId() -> String? {
        return createAutoId(forName: FirebaseConstants.HABITS)
    }
}

// Users references
extension FirebaseManager {
    
    public func getCurrentUserReference() -> DatabaseReference {
        return getDatabaseReference(forName: FirebaseConstants.USERS)
    }
}

