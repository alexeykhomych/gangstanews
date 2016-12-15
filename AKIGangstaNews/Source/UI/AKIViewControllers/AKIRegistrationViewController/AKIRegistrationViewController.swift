//
//  AKIRegistrationViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIRegistrationViewController: AKIGangstaNewsViewController {
    
    var registrationView: AKIRegistrationView? {
        return self.getView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardObserver((self.registrationView?.scrollView)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - View Lifecycle
    
    @IBAction func registrationButton(_ sender: UIButton) {
        self.loadContext()
    }
    
    // MARK: request context
    
    private func loadContext() {
        let context = AKISignUpContext()
        
        self.context = context
        self.model = self.setUser()
        
        context.model = self.model
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
    
    private func setUser() -> AKIUser {
        let user = AKIUser()
        user.email = self.registrationView?.emailField?.text
        user.login = self.registrationView?.loginField?.text
        user.password = self.registrationView?.passwordField?.text
        
        return user
    }
    
    override func modelDidLoad() {
        let controllers = self.navigationController?.viewControllers
        let rootViewController = controllers?[(controllers?.count)! - 2] as? AKILoginViewController
        rootViewController?.user = self.model as! AKIUser?
        
        _ = self.navigationController?.popViewController(animated: true)
    }

}
