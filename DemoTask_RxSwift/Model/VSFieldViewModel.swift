//
//  VSFieldViewModel.swift
//  DemoTask_RxSwift
//
//  Created by rlogical-dev-59 on 15/12/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


// FieldViewModel
protocol VSFieldViewModel
{
    var title: String { get}
    var errorMessage: String { get }

    // Observables
    var value: Variable<String> { get set }
    var errorValue: Variable<String?> { get}

    // Validation
    func validate() -> Bool
}

extension VSFieldViewModel {
    func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}
