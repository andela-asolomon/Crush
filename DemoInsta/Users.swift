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
    
    func getUserById(id: String) -> FAuthData {
        
        usersRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
            println(snapshot.value)
            
            
            
            
        }) { (error) -> Void in
            println(error.localizedDescription)
        }
        
        return FAuthData()
    }
    
    
}
