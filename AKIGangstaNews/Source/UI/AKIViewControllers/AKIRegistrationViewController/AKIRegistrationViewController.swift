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
        self.loadUser()        
        
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
    
    private func loadUser() {
        DispatchQueue.global().async {
            let user = AKIUser()
            let registrationView = self.registrationView
            user.email = registrationView?.emailField?.text
            user.login = registrationView?.loginField?.text
            user.password = registrationView?.passwordField?.text
            
            self.model = user
        }
    }
    
    override func modelDidLoad() {
        DispatchQueue.global().async {
            let controllers = self.navigationController?.viewControllers
            let rootViewController = controllers?[(controllers?.count)! - 2] as? AKILoginViewController
            rootViewController?.model = self.model
            
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

}
