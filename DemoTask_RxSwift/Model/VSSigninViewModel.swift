//
//  VSSigninViewModel.swift
//  DemoTask_RxSwift
//
//  Created by rlogical-dev-59 on 15/12/20.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import Alamofire
import RxRealm
import RealmSwift

class VSSigninViewModel : NSObject {
    
    let model = SigninModel()
    var resultView : RootClass?  = nil
    
    
    private let disposeBag = DisposeBag()
    
    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    
    let emailFieldViewModel = VSEmailViewModel()
    let passwordFieldViewModel = VSPasswordViewModel()
    
    // RX
    //var isLoading = BehaviorRelay(value: false)
    //var isSuccess = BehaviorRelay(value: false)
    //var errorMessage = BehaviorRelay<String?>(value: nil)
    
    var isLoading = Variable(false)
    var isSuccess = Variable(false)
    var errorMessage = Variable<String?>(nil)
    var successMessage = Variable<String?>("")
    
    
    
    func isValidEmail() -> Bool {
        email.bind(to: emailFieldViewModel.value)
        return emailFieldViewModel.validate()
    }
    
    func isValidPassword() -> Bool {
        password.bind(to: passwordFieldViewModel.value)
        return passwordFieldViewModel.validate()
    }
    
    func validForm() -> Bool {
        email.bind(to: emailFieldViewModel.value)
        password.bind(to: passwordFieldViewModel.value)
        
        return emailFieldViewModel.validate() && passwordFieldViewModel.validate()
    }
    
    
    
    func signin() {
        
        // update model
        model.email     = emailFieldViewModel.value.value
        model.password  = passwordFieldViewModel.value.value
        
        
        //CALLING WEBSERVICE
        let param = [
            "email"     :   model.email,
            "password"  :   model.password,
        ]
        
        RRAPIRxManager.rxCall(apiUrl: "http://imaginato.mocklab.io/login", httpMethod: .post, param: param, showingIndicator: true) // Post Request
            .subscribeConcurrentBackgroundToMainThreads()
            .subscribe(onNext: { [self] response in
                
                print(response)
                self.resultView = RootClass(fromDictionary: response as! [String : Any])
                self.errorMessage.value = nil
                
                self.isLoading.value = false
                self.isSuccess.value = true
                

                if self.resultView?.result == 1 {
                    self.successMessage.value = "Login Successful"
                    self.saveRealmData(user: (resultView?.data.user)!)
                }
                else {
                    self.successMessage.value = resultView?.errorMessage
                }
                
                
            }, onError: { error in
                print(error)
                self.isLoading.value = false
                self.errorMessage.value = "Error"
                self.successMessage.value = nil
                self.isSuccess.value = false
            }).disposed(by: disposeBag)
        
        
        /*
        // launch request
        let request = Request(email: model.email, password: model.password)
        VSService.execute(request)
            .`do`(onSubscribe: { [weak self] in
                self?.isLoading.value = true
            })
            .subscribe(onNext: { [weak self] response in
                self?.isLoading.value = false
                self?.isSuccess.value = true
                }, onError: { [weak self] error in
                    self?.isLoading.value = false
                    self?.errorMessage.value = error.message
                    self?.isSuccess.value = false
            }).disposed(by: disposeBag)*/
        
    }
    
    
    func saveRealmData(user: User) {

        let realm = try! Realm()
        let userid = String.init(format: "%d", user.userId)
        let predicate = NSPredicate(format: "userId = %@", userid)
        let records = realm.objects(userDB.self).filter(predicate)

        let record = userDB (
            createdAt: user.createdAt,
            userId: userid,
            userName: user.userName
        )

        if records.count > 0 {
            //UPDATE CURREN USER
            try! realm.write {
                realm.add(record, update: .all)
            }
        }
        else {
            //ADD NEW USER
            try! realm.write {
                realm.add(record)
            }
        }

    }

}


