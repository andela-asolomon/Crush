//
//  Constants.swift
//  DemoInsta
//
//  Created by Ayoola Solomon on 7/7/15.
//  Copyright (c) 2015 Ayoola Solomon. All rights reserved.
//

import Foundation

let Instagram = [
    "consumerKey": "b5662952725241499961ea56a520b754",
    "consumerSecret": "e1c20a308f5d40208367ad24feb1a8ca"
]

let Google = [
    "consumerKey": "1007981792378-djv9k8ppai4ddirf9pbrfvpv1ju4b6o3.apps.googleusercontent.com",
    "consumerSecret": "LE3dkfQ-8XyXXrlM6FDYQStV"
]

func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}