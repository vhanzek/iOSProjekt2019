//
//  UserService.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 06/07/2019.
//

import FirebaseDatabase

class UserService {
    
    private final let USERS = "users"
    
    func saveUser(userID: String, email: String) {
        let ref = Database.database().reference().root
        ref.child(USERS).child(userID).setValue(email)
    }
}
