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

let kAKIUser = "kAKIUser"

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
    
    //MARK: Private methods
    
    private func loadContext() {
        let user = self.user
    
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
    
    private func loadUser() {
        self.user = AKIUser()
        self.user?.email = self.loadDataFromDisk(key: "email")! as? String
        self.user?.password = self.loadDataFromDisk(key: "password")! as? String
        
        self.loginView?.fillFields(user: self.user)
    }
    
    override func modelDidLoad() {
        self.saveDataToDisk(data: self.user?.email as AnyObject, key: "email")
        self.saveDataToDisk(data: self.user?.password as AnyObject, key: "password")
        
        let controller = AKINewsViewController()
        controller.user = self.user
        self.pushViewController(controller)
    }
    
    func check() {
        if 5 > (user?.login?.characters.count)! {
            
        }
        
        if 6 > (user?.password?.characters.count)! {
            
        }
        
    }
    
}
