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
        self.registrationView?.spinnerView?.visible = false
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
        if self.checkValidationEmail((self.registrationView?.emailField?.text)!) {
            self.loadContext()
        } else {
            self.showErrorAllert(message: kAKIErrorMessage)
        }
    }
    
    // MARK: request context
    
    private func loadContext() {
        let context = AKISignUpContext()
        
        self.context = context
        self.loadUser()        
        
        context.model = self.model
        self.setObserver(context)
    }
    
    private func loadUser() {
        let user = AKIUser()
        let registrationView = self.registrationView
        user.email = registrationView?.emailField?.text
        user.login = registrationView?.loginField?.text
        user.password = registrationView?.passwordField?.text
        
        self.model = user
    }
    
    override func modelDidLoad() {
        DispatchQueue.main.async {
            let controllers = self.navigationController?.viewControllers
            let rootViewController = controllers?[(controllers?.count)! - 2] as? AKILoginViewController
            rootViewController?.model = self.model
            
            self.registrationView?.spinnerViewVisible = false
            
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func modelDidFailLoading() {
        DispatchQueue.main.async {
            self.registrationView?.spinnerView?.visible = false
        }
    }
    
    override func modelWillLoading() {
        DispatchQueue.main.async {
            self.registrationView?.spinnerView?.visible = true
        }
    }

    private func checkValidationEmail(_ field: String) -> Bool {        
        let emailTest = NSPredicate(format:kAKIMatches, kEmailRegEx)
        return emailTest.evaluate(with: field)
    }
}
