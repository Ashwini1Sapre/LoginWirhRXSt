//
//  LoginViewModel.swift
//  LoginWirhRXSt
//
//  Created by Knoxpo MacBook Pro on 19/12/20.
//

import Foundation
import RxSwift

import RxRelay

struct LoginViewModel {
    var email = BehaviorRelay(value: "")
    var password = BehaviorRelay(value: "")
    var isValid: Observable<Bool>
    {
        return Observable.combineLatest(email.asObservable(),password.asObservable())
            {
            
            email,password in
            email.isValidEmail() && password.isValidPassword()
            
        }
        
        
    }
    
    
}
