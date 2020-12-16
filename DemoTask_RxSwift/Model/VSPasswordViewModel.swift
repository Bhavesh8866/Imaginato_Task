//
//  VSPasswordViewModel.swift
//  DemoTask_RxSwift
//
//  Created by rlogical-dev-59 on 15/12/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct VSPasswordViewModel : VSFieldViewModel, VSSecureFieldViewModel {
    
    var value: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable(nil)
    
    let title = "Password"
    let errorMessage = "Wrong password !"
    
    var isSecureTextEntry: Bool = true
    
    func validate() -> Bool {
        let pwdPattern = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        guard validateString(value.value, pattern:pwdPattern) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}

// Options for FieldViewModel
protocol VSSecureFieldViewModel {
    var isSecureTextEntry: Bool { get }
}
