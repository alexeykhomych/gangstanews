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
    
    let rer = AKIConstants().kAKILoginRequest
    
    override init() {
        self.login = ""
        self.email = ""
        self.authKey = ""
        self.passwordResetToken = ""
        
        self.content = AKIContent.init(header: "default header", dataText: "default", image: UIImageView.init(image: UIImage.init(named: "logo")))
        self.newsArray = AKIArrayModel()
        self.categories = AKICategoryModel()
    }
    
    init(login: String, email: String, authKey: String, passwordResetToken: String, newsArray: AKIArrayModel) {
        self.login = login
        self.email = email
        self.authKey = authKey
        self.passwordResetToken = passwordResetToken
        self.newsArray?.addObjects(newsArray)
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
    
    private func defaultSettings() {
//        let categories 
//        var array = NSMutableArray()
//        array.add()
    }
}
