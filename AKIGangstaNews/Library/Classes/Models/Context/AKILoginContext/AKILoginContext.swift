//
//  AKILoginContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire

class AKILoginContext: AKIContext {
    
    let constants = AKIConstants()

    let auth: String = "auth/login"
    
    func loginRequest() {
        
        let user = self.model as? AKIUser
        
        let url: String = "\(self.constants.kAKIAPIURL)/\(self.constants.kAKIAuthentikationRequest)"
        let parameters = [
            "email": user?.email,
            "password": user?.password
        ]
        
        let basic = self.convertToBase64(login: (user?.login)!, password: (user?.password)!)

        let headers: HTTPHeaders = [
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
            self.constants.kAKIAuthorization: "Basic \(basic)"
        ]
        
        //            self.constants.kAKIAuthorization: "Basic MTFkc2FkbWFpbEBtYWlsLnVhOmdmZ2RnZGdkZ2Q="
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                    //modelDidLoad
//                    user?.authKey = data["auth_key"]
                    
                }
                break
                
            case .failure(_):
                //modelDidFailLoading
                break
                
            }
        }

    }
    
    private func convertToBase64(login: String, password: String) -> String {
        let plainString = "\(login):\(password)"
        guard let plainData = (plainString as NSString).data(using: String.Encoding.utf8.rawValue) else {
            fatalError()
        }
        
        return (plainData as NSData).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
}
