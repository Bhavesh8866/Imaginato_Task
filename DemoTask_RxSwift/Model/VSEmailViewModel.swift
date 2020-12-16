//
//  VSEmailViewModel.swift
//  DemoTask_RxSwift
//
//  Created by rlogical-dev-59 on 15/12/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// Data FieldViewModel : Email
struct VSEmailViewModel : VSFieldViewModel {
    
    var value: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable(nil)
    
    let title = "Email"
    let errorMessage = "Please enter valid Email"
    
    func validate() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
        guard validateString(value.value, pattern:emailPattern) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}
