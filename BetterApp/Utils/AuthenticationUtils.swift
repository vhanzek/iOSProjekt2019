//
//  AuthenticationUtils.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 06/07/2019.
//

import FirebaseAuth

class AuthenticationUtils {
    
    private static let USER_ID = "uid"
    private static let EMAIL = "email"
    
    static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    static func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    static func getUserEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
    
    static func isUserLoggedIn() -> Bool {
        return getCurrentUser() != nil
    }

}
