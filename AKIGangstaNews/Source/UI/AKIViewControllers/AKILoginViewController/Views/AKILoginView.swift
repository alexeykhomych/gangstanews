//
//  AKILoginView.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKILoginView: UIView {
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var supportView: UIView?
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var mailField: UITextField?
    @IBOutlet var passwordField: UITextField?
    @IBOutlet var authorizationButton: UIButton?
    @IBOutlet var loginButton: UIButton?
    @IBOutlet var forgotPasswordButton: UIButton?
    @IBOutlet var tapRecognizer: UITapGestureRecognizer?
    
    func fillFields(user: AKIUser?) {
        self.mailField?.text = user?.email
        self.passwordField?.text = user?.password
    }
}
