//
//  AKILoginViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire

class AKILoginViewController: AKIAbstractViewController {
    
    var user: AKIUser?
    var context: AKIContext?
    
    var activeTextField: UITextField?
    
    var loginView: AKILoginView? {
        return self.getView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerForKeyboardNotifications()
        self.loadUser()
        self.loadContext()
    }

    override func viewWillDisappear(_ : Bool) {
        self.stopKeyboardObserver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeTextField = textField;
    }
    
    //MARK: View Lifecycle
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(AKINewsViewController(), animated: true)
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
    
    fileprivate func openNextController() {
        
    }
    
//    internal func navigationController(controller: UIViewController) -> UINavigationController {
//        return UINavigationController(rootViewController: controller)
//    }

    private func registerForKeyboardNotifications() {

    }
 
    private func stopKeyboardObserver() {
        
    }
    
    private func keyboardWasShown(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size {
                _ = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
                self.loginView?.scrollView?.scrollRectToVisible((self.activeTextField?.frame)!, animated: true)
            }
        }
    }
    
    private func keyboardWillBeHidden(notification: Notification) {
        self.loginView?.scrollView?.contentInset = UIEdgeInsets.zero
        self.loginView?.scrollView?.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    private func loadContext() {
        let context = AKILoginContext()
        context.model = self.user
        self.context = context
        context.loginRequest()
    }
    
    private func loadUser() {
        self.user = AKIUser()
        self.user?.email = "11dsadmail@mail.ua"
        self.user?.password = "gfgdgdgdgd"
    }
}
