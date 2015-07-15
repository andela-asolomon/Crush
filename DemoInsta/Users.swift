//
//  Users.swift
//  DemoInsta
//
//  Created by Ayoola Solomon on 7/15/15.
//  Copyright (c) 2015 Ayoola Solomon. All rights reserved.
//

import Foundation

class Users {
    
    let ref = Firebase(url: "https://mecrush.firebaseio.com/")
    let usersRef = Firebase(url: "https://mecrush.firebaseio.com/users")
    
    func createUser(authData: FAuthData) {
        
        
    }
    
    func getUserById(id: String) -> FAuthData {
        
        usersRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
            for user in [snapshot.value] {
                if user[id] !== nil {
                    println("my data: \(user[id]!)")
                } else {
                    println("Lol")
                }
            }
            
        }) { (error) -> Void in
            println(error.localizedDescription)
        }
        
        return FAuthData()
    }
    
    
}
