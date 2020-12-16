//
//  ViewController.swift
//  DemoTask_RxSwift
//
//  Created by rlogical-dev-59 on 15/12/20.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var viewModel = VSSigninViewModel()
    
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet weak var lblValidEmail: UILabel!
    @IBOutlet weak var lblValidpassword: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    //MARK:- DIDLOAD
    override func viewDidLoad() {
        
        self.setInitParm()
        self.isEnableLogin(isEnable: false)
        configureBinding()
        configureServiceCallBacks()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func setInitParm()  {
        lblValidEmail.isHidden = true
        lblValidpassword.isHidden = true
    }
    
    private func configureBinding() {
        
        //Binding
        emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        
        let isValidEmail : Observable<Bool> = emailTextField.rx.text.map { [weak self] text -> Bool in
            return self!.viewModel.isValidEmail()
        }
        
        let isValidPassword : Observable<Bool> = passwordTextField.rx.text.map { [weak self] text -> Bool in
            return self!.viewModel.isValidPassword()
        }
        
        
        let everythingValid: Observable<Bool> = Observable.combineLatest( isValidEmail, isValidPassword)
        { (email: Bool, password: Bool) -> Bool in
            
            if email {
                self.lblValidEmail.isHidden = true
            }
            
            if password {
                self.lblValidpassword.isHidden = true
            }
            
            if !email {
                if self.emailTextField.text!.count > 0 {
                    self.lblValidEmail.isHidden = false
                    self.isEnableLogin(isEnable: false)
                }
                else if self.emailTextField.text!.count == 0 {
                    self.lblValidEmail.isHidden = true
                    self.isEnableLogin(isEnable: false)
                }
            }
            else if !password {
                if self.passwordTextField.text!.count > 0 {
                    self.lblValidpassword.isHidden = false
                    self.isEnableLogin(isEnable: false)
                }
                else if self.passwordTextField.text!.count == 0 {
                    self.lblValidpassword.isHidden = true
                    self.isEnableLogin(isEnable: false)
                }
            }
            else {
                self.isEnableLogin(isEnable: true)
            }
            return email && password
        }
        
        everythingValid.bind(to: actionButton.rx.isEnabled).disposed(by: disposeBag)
        
        //BUTTON TAP EVENT
        actionButton.rx.tap
            .`do`(onNext:  { [unowned self] in
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
            }).subscribe(onNext: { [unowned self] in
                
                let isValid = viewModel.validForm()
                if isValid {
                    viewModel.signin()
                }
            }).disposed(by: disposeBag)
    }
    
    func isEnableLogin(isEnable:Bool)  {
        if isEnable {
            self.actionButton.isEnabled = true
            self.actionButton.alpha = 1.0
        }
        else {
            self.actionButton.isEnabled = false
            self.actionButton.alpha = 0.4
        }
    }
    
    
    private func configureServiceCallBacks() {
        // errors
        viewModel.errorMessage.asObservable().filter{_ in true}.bind { errorMessage in
            // Show error
            if errorMessage != nil && errorMessage != "" {
                GlobalData.showAlertTitle("DemoTask", messageStr: errorMessage!, viewController: self)
            }
            
        }.disposed(by: disposeBag)
        
        // success
        viewModel.successMessage.asObservable().filter{_ in true}.bind { sucessMessage in
            // Show error
            if sucessMessage != nil && sucessMessage != "" {
                GlobalData.showAlertTitle("DemoTask", messageStr: sucessMessage!, viewController: self)
            }
            
        }.disposed(by: disposeBag)
    }
}

