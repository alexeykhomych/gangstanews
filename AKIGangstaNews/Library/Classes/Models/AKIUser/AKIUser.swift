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
    
    override init() {
        self.login = "default"
        self.email = "default"
        self.authKey = "default"
        self.passwordResetToken = ""
        self.modelData = AKIContent.init(dataText: "default", imageModel: UIImageView.init(image: UIImage.init(named: "logo")))
    }
    
    init(login: String, email: String, authKey: String, passwordResetToken: String) {
        self.login = login
        self.email = email
        self.authKey = authKey
        self.passwordResetToken = passwordResetToken
    }
    
    required init(coder: NSCoder) {
//        super.init(coder: coder)
        
        self.login = coder.decodeObject(forKey: "login") as? String
        self.email = coder.decodeObject(forKey: "email") as? String
        self.authKey = coder.decodeObject(forKey: "authKey") as? String
        self.passwordResetToken = coder.decodeObject(forKey: "passwordResetToken") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        // super.encodeWithCoder(aCoder) is optional, see notes below
        aCoder.encode(self.login, forKey: "login")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.authKey, forKey: "authKey")
        aCoder.encode(self.passwordResetToken, forKey: "passwordResetToken")
    }
    
//    func imageModel() -> id_t imageModel {
//        return nil
//    }
}
/*
 struct User: Equatable, CustomDebugStringConvertible {
 
 var firstName: String
 var lastName: String
 var imageURL: String
 
 init(firstName: String, lastName: String, imageURL: String) {
 self.firstName = firstName
 self.lastName = lastName
 self.imageURL = imageURL
 }
 }
 
 extension User {
 var debugDescription: String {
 return firstName + " " + lastName
 }
 }
*/
