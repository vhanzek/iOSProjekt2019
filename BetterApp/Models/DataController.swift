//
//  Database.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import FirebaseDatabase

class DataController {
    
    static let shared = DataController()
    
    private init() {}
    
    private lazy var database = Database.database().reference()
}
