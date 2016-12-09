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

class AKILoginViewController: AKIAbstractViewController {
    
    var user: AKIUser?
    var context: AKIContext?
    
    var activeTextField: UITextField?
    
    var observer:Observable<AKIUser>?
    let disposebag = DisposeBag()
    
    var loginView: AKILoginView? {
        return self.getView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerForKeyboardNotifications()
        
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
        self.loadUser()
        self.loadContext()
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
        let user = self.loadUser()
        
        let context = AKILoginContext()
        context.model = user
        let observer = context.observer()
        self.user = user
        
        observer.subscribe(onNext: { next in
            print(next)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            self.modelDidLoad()
            
        }, onDisposed: {
            
        }).addDisposableTo(self.disposebag)
    }
    
    private func loadUser() -> AKIUser {
        let user = AKIUser()
        
        user.email = self.loginView?.mailField?.text
        user.password = self.loginView?.passwordField?.text
        
        return user
    }
    
    private func modelDidLoad() {
        let controller = AKINewsViewController()
        controller.user = self.user
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
