//
//  AKILoginViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKILoginViewController: AKIAbstractViewController {
    
    var loginView: AKILoginView? {
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
    
    //MARK: View Lifecycle
    
    @IBAction func loginButton(sender: UIButton) {
        self.navigationController?.pushViewController(AKINewsViewController(), animated: true)
    }
    
    @IBAction func authorizationButton(sender: UIButton) {
        self.navigationController?.pushViewController(AKIRegistrationViewController(), animated: true)
    }
    
    @IBAction func forgotPasswordButton(sender: UIButton) {
        self.navigationController?.pushViewController(AKIConfirmEmailViewController(), animated: true)
    }
    
    //MARK: Private methods
    
    private func openNextController() {
        
    }
    
//    internal func navigationController(controller: UIViewController) -> UINavigationController {
//        return UINavigationController(rootViewController: controller)
//    }


}
