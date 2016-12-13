//
//  AKIUser.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 30.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKIUser: NSObject, NSCoding {
    
    var login: String?
    var email: String?
    var authKey: String?
    var password: String?
    var passwordResetToken: String?
    var content: AKIContent?
    var newsArray: AKIArrayModel?
    var categories: AKICategoryModel?
    
    let constants = AKIConstants()
    
    override convenience init()
    {
        self.init(login: "",
                  email: "",
                  authKey: "",
                  passwordResetToken: "",
                  newsArray: AKIArrayModel(),
                  categories: AKICategoryModel())
    }
    
    init(login: String,
         email: String,
         authKey: String,
         passwordResetToken: String,
         newsArray: AKIArrayModel,
         categories: AKICategoryModel)
    {
        self.login = login
        self.email = email
        self.authKey = authKey
        self.passwordResetToken = passwordResetToken
        self.newsArray = newsArray
        self.categories = categories
    }
    
    required init(coder: NSCoder) {
        let constants = self.constants
        self.login = coder.decodeObject(forKey: constants.kAKILogin) as? String
        self.email = coder.decodeObject(forKey: constants.kAKIEmail) as? String
        self.authKey = coder.decodeObject(forKey: constants.kAKIAuthKey) as? String
        self.passwordResetToken = coder.decodeObject(forKey: constants.kAKIPasswordResetToken) as? String
        self.newsArray = coder.decodeObject(forKey: constants.kAKINews) as! AKIArrayModel?
        print("user decoded")
    }
    
    func encode(with aCoder: NSCoder) {
        let constants = self.constants
        aCoder.encode(self.login, forKey: constants.kAKILogin)
        aCoder.encode(self.email, forKey: constants.kAKIEmail)
        aCoder.encode(self.authKey, forKey: constants.kAKIAuthKey)
        aCoder.encode(self.passwordResetToken, forKey: constants.kAKIPasswordResetToken)
        aCoder.encode(self.newsArray, forKey: constants.kAKINews)
        print("user encoded")
    }
}
