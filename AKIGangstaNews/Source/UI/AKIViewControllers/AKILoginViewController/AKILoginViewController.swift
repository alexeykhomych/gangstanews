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
    
    //MARK: Initializations and Deallocations

    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardObserver((self.loginView?.scrollView)!)
        self.loginView?.spinnerView?.visible = false
        self.loadAuthKey()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loginView?.fillFields(user: (self.model as! AKIUser?))
    }
    
    //MARK: View Lifecycle
    
    @IBAction func loginButton(_ sender: UIButton) {
        if self.checkValidationEmail((self.loginView?.mailField?.text)!) {
            self.loadContext()
        } else {
            self.showErrorAllert(message: kAKIErrorMessage)
        }
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(AKIRegistrationViewController(), animated: true)
    }
    
    //MARK: Private methods
    
    private func loadContext() {
        self.loadUser()
        let context = AKILoginContext()
        context.model = self.model as! AKIUser?
        self.setObserver(context)
    }
    
    private func loadAuthKey() {
        let user = AKIUser()
        self.model = user
        user.authKey = self.loadDataFromDisk(key: kAKIParserAuthKey)! as? String
        
        if user.authKey != nil && !(user.authKey?.isEmpty)! {
            self.pushViewController(AKINewsViewController(), model: user)
        }
    }
    
    private func loadUser() {
        let user = AKIUser()
        self.model = user
        let loginView = self.loginView
        user.email = loginView?.mailField?.text
        user.password = loginView?.passwordField?.text
    }
    
    override func modelDidLoad() {
        let user = self.model as! AKIUser?
        self.saveDataToDisk(data: user?.authKey as AnyObject, key: kAKIParserAuthKey)
        self.pushViewController(AKINewsViewController(), model: user!)
    }
    
    private func checkValidationEmail(_ field: String) -> Bool {        
        let emailTest = NSPredicate(format:kAKIMatches, kEmailRegEx)
        return emailTest.evaluate(with: field)
    }    
}
