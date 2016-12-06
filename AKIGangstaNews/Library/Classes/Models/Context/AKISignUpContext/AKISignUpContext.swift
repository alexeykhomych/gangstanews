//
//  AKISignUpContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire

class AKISignUpContext: AKIContext {
    
    let constants = AKIConstants()
    let signUp: String = "signup"
    
    func signUpRequest() {
        let user = self.model as? AKIUser
        
        let url: String = "\(self.constants.kAKIAPIURL)\(self.constants.kAKISignupRequest)"
        let parameters = [
            self.constants.kAKIUsername: user?.login,
            self.constants.kAKIPasswordHash: user?.password,
            self.constants.kAKIEmail: user?.email
        ]
        
        let headers: HTTPHeaders = [
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON
        ]
        
        self.request(url: url, parameters: parameters, headers: headers)
        
    }

    private func request(url: String, parameters: Parameters, headers: HTTPHeaders) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch(response.result) {
            case .success(_):
                if let json = response.result.value as? NSDictionary {
                    //modelDidLoad
                    
                    guard let data = json.object(forKey: "data") as? [Any] else { return }
                    guard let dictionary = data[0] as? [String: Any] else { return }
                    
                    let user = self.model as? AKIUser
                    user?.authKey = dictionary[self.constants.kAKIAuthKey] as? String
                }
                break
                
            case .failure(_):
                //modelDidFailLoading
                print(response.result.value as Any)
                break
                
            }
        }
    }
    
}