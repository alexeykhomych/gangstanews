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
    
    override init() {
        self.newsArray = AKIArrayModel()
        self.categories = AKICategoryModel()
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
        self.login = coder.decodeObject(forKey: kAKILogin) as? String
        self.email = coder.decodeObject(forKey: kAKIEmail) as? String
        self.authKey = coder.decodeObject(forKey: kAKIParserAuthKey) as? String
        self.passwordResetToken = coder.decodeObject(forKey: kAKIPasswordResetToken) as? String
        self.newsArray = coder.decodeObject(forKey: kAKINews) as! AKIArrayModel?
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.login, forKey: kAKILogin)
        aCoder.encode(self.email, forKey: kAKIEmail)
        aCoder.encode(self.authKey, forKey: kAKIParserAuthKey)
        aCoder.encode(self.passwordResetToken, forKey: kAKIPasswordResetToken)
        aCoder.encode(self.newsArray, forKey: kAKINews)
    }
}
