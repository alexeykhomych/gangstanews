//
//  AKIConstants.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 02.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIConstants: NSObject {
    
    let kAKIAPIURL = "http://7a1ae016.ngrok.io/"
    
    let kAKILoginRequest = "auth/login"
    let kAKILogoutRequest = "auth/logout"
    let kAKISignupRequest = "signup"
    let kAKICategoriesRequest = "categories"
    let kAKINewsRequest = "news"
    let kAKIDetailNewsRequest = "news/"
    
    let kAKIAuthorizationRequest = "Authorization"
    
    let kAKIAuthorization = "Authorization"
    let kAKIContentType = "Content-Type"
    let kAKIApplicationJSON = "application/json"
    
    let kAKIEmail = "email"
    let kAKIPassword = "password"
    let kAKIPasswordHash = "password_hash"
    let kAKIUsername = "username"
    let kAKIAuthKey = "auth_key"
    
    let kAKIData = "data"
    
    let kAKIPasswordResetToken = "password_reset_token"
    
}
