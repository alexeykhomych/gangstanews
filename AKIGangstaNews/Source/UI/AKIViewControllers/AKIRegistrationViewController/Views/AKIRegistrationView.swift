//
//  AKIRegistrationView.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIRegistrationView: AKISpinnerViewContainer {

    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var supportView: UIView?
    @IBOutlet var tapRecognizer: UITapGestureRecognizer?
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var emailField: UITextField?
    @IBOutlet var passwordField: UITextField?
    @IBOutlet var loginField: UITextField?
    @IBOutlet var loginButton: UIButton?
    
}
