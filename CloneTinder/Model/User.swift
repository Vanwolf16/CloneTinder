//
//  User.swift
//  TinderClone
//
//  Created by David Murillo on 6/9/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

struct User {
    var name:String
    var age:Int
    var email:String
    let uid:String
    let profileImageUrl:String
    
    init(dictionary:[String:Any]) {
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["imageUrls"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
}
