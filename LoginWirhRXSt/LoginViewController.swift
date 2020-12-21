//
//  LoginViewController.swift
//  LoginWirhRXSt
//
//  Created by Knoxpo MacBook Pro on 19/12/20.
//


import UIKit
import RxSwift
import RxCocoa


class LoginViewController: UIViewController {
    @IBOutlet weak var textFldEmail: UITextField!
    @IBOutlet weak var textFldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var loginViewModel = LoginViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rxBinding()
    }
    
    func rxBinding() {
        _ = textFldEmail.rx.text.map {$0 ?? ""}.bind(to: loginViewModel.email)
        _ = textFldPassword.rx.text.map {$0 ?? ""}.bind(to: loginViewModel.password)
        _ = loginViewModel.isValid.bind(to: btnLogin.rx.isEnabled)
        loginViewModel.isValid.subscribe(onNext: {[weak self] isValid in
            self?.btnLogin.alpha = isValid ? 1 : 0.4
            self?.btnLogin.isEnabled = isValid
            print(isValid)
            }, onError: { error in
                print(error)
        }, onCompleted: {
            print("complete")
        }).disposed(by: disposeBag)
    }

    @IBAction func actionResignKeyboard(_ sender: Any) {
        dismissKeybaord()
    }
    
    @IBAction func actionLogin(_ sender: Any) {
       dismissKeybaord()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) { [weak self] in
            guard let strongSelf = self else { return }
            let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as! HomeViewController
            self?.navigationController?.pushViewController(vc, animated: true)
           // appdelegate().window?.rootViewController = vc
        }
    }
    
    func dismissKeybaord() {
        textFldEmail.resignFirstResponder()
        textFldPassword.resignFirstResponder()
    }
}
