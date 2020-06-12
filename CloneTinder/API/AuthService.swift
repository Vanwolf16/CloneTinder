//
//  AuthService.swift
//  CloneTinder
//
//  Created by David Murillo on 6/10/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

struct AuthCredentials {
    let email:String
    let password:String
    let fullname:String
    let profileImage:UIImage
}

struct AuthService{
    
    static func logUserIn(withEmail email:String,password:String,completion:AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
        
    }
    
    static func registerUser(withCredentials credentials:AuthCredentials,completion:@escaping (Error?) -> Void){
        Service.uploadImage(image: credentials.profileImage) { (imageUrl) in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error{
                    print("No Firestore:\(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else {return}
                
                let data = ["email":credentials.email,
                            "fullname":credentials.fullname,
                            "imageUrls":imageUrl,
                            "uid":uid,"age":18] as [String:Any]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
                
            }
        }
    }
}
