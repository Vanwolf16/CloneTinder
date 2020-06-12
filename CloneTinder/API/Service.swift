//
//  Service.swift
//  CloneTinder
//
//  Created by David Murillo on 6/10/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit
import Firebase

struct Service {
    
    static func fetchUser(withUid uid:String,completion:@escaping (User) -> Void){
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
   static func fetchUsers(completion:@escaping([User]) -> ()){
        var users = [User]()
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                if users.count == snapshot?.documents.count{
                    print("Document count: \(snapshot?.documents.count)")
                    completion(users)
                }
            })
        }
    }
    
    //Upload a image to firestorage
    static func uploadImage(image:UIImage,completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error{
                print("Error:\(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
            
        }
        
    }
}

