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
    
    var loginView: AKILoginView? {
        return self.getView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardObserver((self.loginView?.scrollView)!)
        
        self.loadUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loginView?.fillFields(user: (self.model as! AKIUser?))
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
        
    }
    
    //MARK: Private methods
    
    private func loadContext() {
        let context = AKILoginContext()
        context.model = self.model as! AKIUser?
        self.setObserver(context, cls: AKILoginContext.self)
        
//        observer.subscribe(onNext: { next in
//            print(next)
//        }, onError: { error in
//            print(error)
//        }, onCompleted: {
//            self.modelDidLoad()
//            
//        }, onDisposed: {
//            
//        }).addDisposableTo(self.disposeBag)
    }
    
    private func loadUser() {
        DispatchQueue.global().async {
            let user = AKIUser()
            self.model = user
            user.authKey = self.loadDataFromDisk(key: kAKIParserAuthKey)! as? String
            
            if user.authKey == nil {
                let loginView = self.loginView
                user.login = loginView?.mailField?.text
                user.password = loginView?.passwordField?.text
            } else {
                self.pushViewController(AKINewsViewController(), model: user)
            }
        }
        
    }
    
    override func modelDidLoad() {
        DispatchQueue.global().async {
            let user = self.model as! AKIUser?
            self.saveDataToDisk(data: user?.authKey as AnyObject, key: kAKIParserAuthKey)
            self.pushViewController(AKINewsViewController(), model: user!)
        }
    }
    
    
    func check() {
//        if 5 > (user?.login?.characters.count)! {
//            
//        }
//        
//        if 6 > (user?.password?.characters.count)! {
//            
//        }
    }
    
}
