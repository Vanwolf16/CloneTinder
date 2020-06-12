//
//  AuthenticationViewModel.swift
//  TinderClone
//
//  Created by David Murillo on 6/9/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import Foundation
import UIKit

protocol AuthentionViewModel {
    var formIsValid:Bool{get}
}

struct LoginViewModel:AuthentionViewModel {
    var email:String?
    var password:String?
    
    var formIsValid:Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
}

struct RegistrationViewModel:AuthentionViewModel {
    
    var email:String?
    var fullname:String?
    var password:String?
    
    var formIsValid:Bool{
         return email?.isEmpty == false && password?.isEmpty == false
            && fullname?.isEmpty == false
     }
    
}
