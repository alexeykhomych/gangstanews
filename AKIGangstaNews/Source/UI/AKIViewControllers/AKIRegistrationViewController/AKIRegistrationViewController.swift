//
//  AKIRegistrationViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIRegistrationViewController: AKIAbstractViewController {
    
    var context = AKISignUpContext()
    var user: AKIUser?
    
    var registrationView: AKIRegistrationView? {
        return self.getView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        let controllers = self.navigationController?.viewControllers
        let rootViewController = controllers?[(controllers?.count)! - 2] as? AKILoginViewController
        rootViewController?.user = self.user
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: request context
    
    private func loadContext() {
        let context = AKISignUpContext()
        self.context = context
        let model = self.setUser()
        context.model = model
        self.user = model
        
        context.signUpRequest()
    }
    
    private func setUser() -> AKIUser {
        let user = AKIUser()
        user.email = self.registrationView?.emailField?.text
        user.login = self.registrationView?.loginField?.text
        user.password = self.registrationView?.passwordField?.text
        
        return user
    }

}
