//
//  SigninModel.swift
//  DemoTask_RxSwift
//
//  Created by rlogical-dev-59 on 15/12/20.
//

import Foundation

// Model class : Signin (email, password)
class SigninModel : NSObject
{
    var email: String = ""
    var password: String = ""
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
    
    override init() {
        super.init()
    }
}
