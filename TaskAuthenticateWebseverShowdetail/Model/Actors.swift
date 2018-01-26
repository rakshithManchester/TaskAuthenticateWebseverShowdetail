//
//  Actors.swift
//  TaskAuthenticateWebseverShowdetail
//
//  Created by Rakshith Appaiah on 1/25/18.
//  Copyright © 2018 Rakshith Appaiah. All rights reserved.
//

import Foundation

/// ActorDetails : actor class and its property is declared.
class ActorDetails: NSObject {
    let name : String
    let descriptions : String
    let dob  : String
    let country : String
    let image : String
    
    init(name: String,descriptions: String,dob : String,country: String,image: String) {
        self.name = name
        self.descriptions = descriptions
        self.dob = dob
        self.country = country
        self.image = image
    }
}
