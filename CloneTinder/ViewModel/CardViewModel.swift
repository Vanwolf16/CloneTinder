//
//  CardViewModel.swift
//  TinderClone
//
//  Created by David Murillo on 6/9/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

class CardViewModel {
    
     let user:User
    
    let userInfoText:NSAttributedString
    
    private var imageIndex = 0
    
     var imageUrl:URL?
    
    init(user:User) {
        self.user = user
        
        let attributedTxt = NSMutableAttributedString(string: user.name, attributes: [.font:UIFont.systemFont(ofSize: 32, weight: .heavy),.foregroundColor:UIColor.white])
        
        attributedTxt.append(NSAttributedString(string: "  \(user.age)", attributes: [.font:UIFont.systemFont(ofSize: 24),.foregroundColor:UIColor.white]))
        
        self.userInfoText = attributedTxt
        
        self.imageUrl = URL(string: user.profileImageUrl)
        
    }
    
    //Move to next photo
   func showNextPhoto(){
    /*
    guard imageIndex < user.images.count - 1 else {return}
        imageIndex += 1
        self.imageToShow = user.images[imageIndex]
    */
    }
    
    func showPreviousPhoto(){
        /*
         guard imageIndex > 0 else {return}
        imageIndex -= 1
        self.imageToShow = user.images[imageIndex]
        */
    }
    
}
