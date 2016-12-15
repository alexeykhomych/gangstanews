//
//  AKILoginViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKILoginViewController: AKIGangstaNewsViewController {
    
    var activeTextField: UITextField?
    
//    var observer:Observable<AKIUser>?
//    let disposeBag = DisposeBag()
    
    var loginView: AKILoginView? {
        return self.getView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardObserver((self.loginView?.scrollView)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loginView?.mailField?.text = self.user?.email
        self.loginView?.passwordField?.text = self.user?.password
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeTextField = textField;
    }
    
    //MARK: View Lifecycle
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.loadContext()
    }
    
    @IBAction func authorizationButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(AKIRegistrationViewController(), animated: true)
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(AKIConfirmEmailViewController(), animated: true)
    }
    
    @IBAction func tapGestureRecognizer(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: Private methods
    
    private func loadContext() {
        let user = (self.user != nil) ? self.user : self.loadUser()
        
        let context = AKILoginContext()
        context.model = user
        let observer = context.observer()
        
        observer.subscribe(onNext: { next in
            print(next)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            self.modelDidLoad()
            
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
    }
    
    private func loadUser() -> AKIUser {
        let user = AKIUser()
        
        user.email = self.loginView?.mailField?.text
        user.password = self.loginView?.passwordField?.text
        
        return user
    }
    
    override func modelDidLoad() {
        let controller = AKINewsViewController()
        controller.user = self.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
