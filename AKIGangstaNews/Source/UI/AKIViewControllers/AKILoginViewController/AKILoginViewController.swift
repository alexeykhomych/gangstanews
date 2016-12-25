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
        self.loadContext()
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
        DispatchQueue.global().async {
            let user = AKIUser()
            self.model = user
            user.authKey = self.loadDataFromDisk(key: kAKIParserAuthKey)! as? String
            
            if user.authKey == nil {
                self.loadUser()
            } else {
                self.pushViewController(AKINewsViewController(), model: user)
            }
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
