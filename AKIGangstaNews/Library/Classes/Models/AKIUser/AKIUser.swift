//
//  AKIUser.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 30.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIUser: NSObject, NSCoding {
    
    var login: String?
    var email: String?
    var authKey: String?
    var password: String?
    var passwordResetToken: String?
    var modelData: AKIContent?
    var newsArray: NSMutableArray
    var newsCategories: Array<Any>?
    
    override init() {
        self.login = "default"
        self.email = "default"
        self.authKey = "default"
        self.passwordResetToken = ""
        
        self.modelData = AKIContent.init(header: "default header", dataText: "default", image: UIImageView.init(image: UIImage.init(named: "logo")))
        self.newsArray = NSMutableArray()
        self.newsArray.add(self.modelData!)
    }
    
    init(login: String, email: String, authKey: String, passwordResetToken: String, newsArray: NSMutableArray) {
        self.login = login
        self.email = email
        self.authKey = authKey
        self.passwordResetToken = passwordResetToken
        self.newsArray = newsArray
        self.newsArray.add(self.modelData!)
    }
    
    required init(coder: NSCoder) {
        self.login = coder.decodeObject(forKey: "login") as? String
        self.email = coder.decodeObject(forKey: "email") as? String
        self.authKey = coder.decodeObject(forKey: "authKey") as? String
        self.passwordResetToken = coder.decodeObject(forKey: "passwordResetToken") as? String
        self.newsArray = coder.decodeObject(forKey: "newsArray") as! NSMutableArray
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.login, forKey: "login")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.authKey, forKey: "authKey")
        aCoder.encode(self.passwordResetToken, forKey: "passwordResetToken")
        aCoder.encode(self.newsArray, forKey: "newsArray")
    }
    
}
